BEGIN
\set product_id random(1, 99999)
\set offset 5 * random(1, 10)
\set user_id 10000004
-- Write Test Case
-- INSERT INTO reviews.reviews
--   (product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality)
--   VALUES
--   (:product_id, :user_id, 'This is my favorite product!!!', 'I really love this product.  It is everything I expected plus more.  So happy I brought this product', true, 'great', 'perfect', 'perfect', 'great', 'great');

-- Read Test Case
SELECT *
  FROM reviews.products
  WHERE product_id = :product_id;
WITH reviews AS (
  SELECT review_id, user_id, title, text, recommends, reviews.mapRating(rating_overall) AS rating_overall, is_helpful, is_not_helpful, created_at
  FROM reviews.reviews
  WHERE product_id = :product_id
  ORDER BY created_at DESC NULLS LAST LIMIT 5 OFFSET :offset
)
SELECT r.*, u.nickname, u.verified,
  (
    SELECT array_agg(link) AS links
    FROM reviews.photos
    WHERE review_id = r.review_id
    GROUP BY review_id
  )
  FROM reviews AS r JOIN
  reviews.users AS u USING (user_id);
END;

