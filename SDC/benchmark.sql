BEGIN
\set product_id random(1, 99999)
\set offset 5 * random(1, 10)
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


-- SELECT r.*, u.nickname, u.verified,
--   (
--     SELECT array_agg(link) AS links
--       FROM reviews.photos
--       WHERE review_id = r.review_id
--       GROUP BY review_id
--   )
--   FROM
--   (
--     SELECT review_id, user_id, title, text, recommends, reviews.mapRating(rating_overall) AS rating_overall, is_helpful, is_not_helpful, created_at
--       FROM reviews.reviews
--       WHERE product_id = :product_id
--       ORDER BY created_at DESC NULLS LAST LIMIT 5 OFFSET :offset
--   ) AS r JOIN
--   (
--     SELECT review_id, nickname, verified
--       FROM reviews.users_by_product
--       WHERE product_id = :product_id
--   ) AS u USING (review_id);