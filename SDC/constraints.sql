ALTER TABLE reviews.reviews ADD CONSTRAINT prodfk FOREIGN KEY (product_id) REFERENCES reviews.products(product_id);

ALTER TABLE reviews.reviews ADD CONSTRAINT userfk FOREIGN KEY (user_id) REFERENCES reviews.users(user_id);

CREATE INDEX user_id_index ON reviews.reviews(user_id);

-- CREATE INDEX newest_index ON reviews.reviews(product_id, created_at DESC NULLS LAST);
CREATE INDEX newest_index ON reviews.reviews(product_id, created_at DESC NULLS LAST) INCLUDE(user_id, title, text, recommends, rating_overall, is_helpful, is_not_helpful);

-- CLUSTER VERBOSE reviews.reviews USING newest_index;
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