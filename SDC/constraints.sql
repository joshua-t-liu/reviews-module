ALTER TABLE reviews.reviews ADD CONSTRAINT prodfk FOREIGN KEY (product_id) REFERENCES reviews.products(product_id);

ALTER TABLE reviews.reviews ADD CONSTRAINT userfk FOREIGN KEY (user_id) REFERENCES reviews.users(user_id);

CREATE INDEX newest_index ON reviews.reviews(product_id, created_at DESC NULLS LAST) INCLUDE(review_id, user_id, title, text, recommends, rating_overall, is_helpful, is_not_helpful);

CREATE INDEX email_index ON reviews.users(email);

VACUUM ANALYZE reviews.users;
VACUUM ANALYZE reviews.photos;
VACUUM ANALYZE reviews.reviews;

CREATE OR REPLACE FUNCTION reviews.mapRating(category rating) RETURNS integer AS $$
DECLARE val integer;
BEGIN
  SELECT r.score INTO val FROM reviews.ratings as r WHERE r.rating = category;
  RETURN val;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reviews.mapRatingCentered(category ratings_centered) RETURNS integer AS $$
DECLARE val integer;
BEGIN
  SELECT r.score INTO val FROM reviews.ratings_centered as r WHERE r.ratings_centered = category;
  RETURN val;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reviews.update_product_summary() RETURNS trigger AS $product_summary$
  DECLARE id integer := OLD.product_id;
  BEGIN
    UPDATE reviews.products AS p SET (
      recommends,
      review_count,
      rating_overall,
      rating_size,
      rating_width,
      rating_comfort,
      rating_quality,
      count_5,
      count_4,
      count_3,
      count_2,
      count_1) = (
        SELECT
        100 * count(CASE WHEN recommends = true THEN true ELSE NULL END) / count(*),
        count(review_id),
        avg(reviews.mapRating(rating_overall)),
        avg(reviews.mapRatingCentered(rating_size)),
        avg(reviews.mapRatingCentered(rating_width)),
        avg(reviews.mapRating(rating_comfort)),
        avg(reviews.mapRating(rating_quality)),
        count(CASE WHEN rating_overall = 'great' THEN true ELSE NULL END),
        count(CASE WHEN rating_overall = 'good' THEN true ELSE NULL END),
        count(CASE WHEN rating_overall = 'average' THEN true ELSE NULL END),
        count(CASE WHEN rating_overall = 'fair' THEN true ELSE NULL END),
        count(CASE WHEN rating_overall = 'poor' THEN true ELSE NULL END)
        FROM reviews.reviews AS r
        WHERE r.product_id = id)
    WHERE p.product_id = id;
    RETURN NULL;
  END;
$product_summary$ LANGUAGE plpgsql;


CREATE TRIGGER update_product AFTER INSERT OR UPDATE OR DELETE
  ON reviews.reviews
  FOR EACH ROW
    EXECUTE FUNCTION reviews.update_product_summary();

CREATE OR REPLACE FUNCTION reviews.createReview(user_row reviews.users, review jsonb) RETURNS void AS $$
DECLARE
  id integer;
BEGIN
  SELECT user_id INTO id FROM reviews.users AS u WHERE u.email = user_row.email;

  IF NOT FOUND THEN
    WITH new_user AS (INSERT INTO reviews.users (nickname, email, verified) VALUES (user_row.nickname, user_row.email, user_row.verified) RETURNING *)
    SELECT user_id INTO id FROM new_user;
  END IF;

  INSERT INTO reviews.reviews
  (product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality)
  VALUES (CAST(review->>'product_id' AS integer), id, review->>'title', review->>'text', CAST(review->>'recommends' AS boolean), CAST(review->>'rating_overall' AS rating), CAST(review->>'rating_size' AS ratings_centered), CAST(review->>'rating_width' AS ratings_centered), CAST(review->>'rating_comfort' as rating), CAST(review->>'rating_quality' AS rating));

  -- (jsonb_to_record(jsonb_set(review, '{user_id}', format('%s',id)::jsonb))) AS x(product_id int, user_id int, title text, text text, recommends boolean, rating_overall rating, rating_size rating_centered, rating_width rating_centered, rating_comfort rating, rating_quality rating)
END;
$$ LANGUAGE plpgsql;

-- CREATE MATERIALIZED VIEW reviews.users_by_product AS
--   SELECT review_id, product_id, nickname, verified
--     FROM reviews.reviews JOIN reviews.users USING (user_id);

-- CREATE INDEX users_by_product_index ON reviews.users_by_product(product_id, review_id) INCLUDE (nickname, verified);

-- CLUSTER VERBOSE reviews.users_by_product USING users_by_product_index;