BEGIN
\set product_id random(1, 99999)
\set offset 5 * random(1, 10)
SELECT *
  FROM reviews.products
  WHERE product_id = :product_id;
WITH reviews_by_product AS (
  SELECT user_id, title, text, recommends, rating_overall, is_helpful, is_not_helpful, created_at
    FROM reviews.reviews
    WHERE product_id = :product_id
    ORDER BY created_at DESC NULLS LAST
    LIMIT 5 OFFSET :offset
), users_by_reviews AS (
  SELECT *
    FROM reviews.users
    WHERE user_id IN (SELECT user_id FROM reviews_by_product)
)
SELECT r.*, u.nickname, u.verified
  FROM reviews_by_product AS r, users_by_reviews AS u
  WHERE r.user_id = u.user_id;
END;

-- explain (analyze, buffers) SELECT *,
--   (SELECT array_agg(link) AS photos
--   FROM reviews.photos
--   WHERE reviews.photos.review_id = r.review_id)
--   FROM reviews.reviews_mat AS r
--   WHERE product_id = 22222
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET 75;

-- SELECT *,
--   (SELECT array_agg(link) AS photos
--   FROM reviews.photos
--   WHERE reviews.photos.review_id = r.review_id)
--   FROM
--   (SELECT *
--   FROM reviews.reviews
--   WHERE product_id = :product_id
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET :offset) as r, reviews.users as u
--   WHERE r.user_id = u.user_id;

-- SELECT user_id
--   FROM reviews.reviews
--   WHERE product_id = 77999
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET 75;

-- explain (analyze, buffers) SELECT *,
--   (SELECT array_agg(link) AS photos
--     FROM reviews.photos
--     WHERE reviews.photos.review_id = r.review_id)
--   FROM
--   (SELECT *
--     FROM reviews.reviews
--     WHERE product_id = 77999
--     ORDER BY created_at DESC NULLS LAST
--     LIMIT 5 OFFSET 75) as r,
--   (SELECT *
--     FROM reviews.users
--     WHERE user_id = r.user_id ) as u
--   WHERE r.user_id = u.user_id;

-- explain (analyze, buffers) WITH reviews_by_product AS (
--   SELECT title, text, recommends, rating_overall, is_helpful, is_not_helpful, created_at
--     FROM reviews.reviews
--     WHERE product_id = :product_id
--     ORDER BY created_at DESC NULLS LAST
--     LIMIT 5 OFFSET :offset
-- ), users_by_reviews AS (
--   SELECT *
--     FROM reviews.users
--     WHERE user_id IN (SELECT user_id FROM reviews_by_product)
-- )
-- SELECT r.*, u.nickname, u.verified
--   FROM reviews_by_product AS r, users_by_reviews AS u
--   WHERE r.user_id = u.user_id;

-- explain (analyze, buffers) SELECT *,
--   (SELECT array_agg(link) AS photos
--   FROM reviews.photos
--   WHERE reviews.photos.review_id = r.review_id)
--   FROM
--   (SELECT *
--   FROM reviews.reviews_mat
--   WHERE product_id = 88999
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET 75) as r;

-- explain (analyze, buffers) SELECT *
--   FROM
--   (SELECT *
--   FROM
--   (SELECT *
--     FROM reviews.reviews
--     WHERE product_id = 33333
--     ORDER BY created_at DESC NULLS LAST
--     LIMIT 5 OFFSET 50
--     ) as r, reviews.users as u
--   WHERE r.user_id = u.user_id) as prd LEFT JOIN (SELECT review_id, array_agg(link) AS photos
--     FROM reviews.photos
--     WHERE reviews.photos.product_id = 33333
--     GROUP BY review_id) as photo ON prd.review_id = photo.review_id;

-- SELECT *
--   FROM
--   (SELECT *
--   FROM reviews.reviews
--   WHERE product_id = :product_id
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET :offset
--   ) as r, reviews.users as u, (SELECT review_id, array_agg(link) AS photos
--     FROM reviews.photos
--     WHERE reviews.photos.product_id = :product_id
--     GROUP BY review_id) as p
--   WHERE r.user_id = u.user_id AND r.review_id = p.review_id;