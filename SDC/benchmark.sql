BEGIN
\set product_id random(1, 99999)
\set offset 5 * random(1, 10)
SELECT *
  FROM reviews.products
  WHERE product_id = :product_id;
SELECT *
  FROM
  (SELECT *
  FROM reviews.reviews
  WHERE product_id = :product_id
  ORDER BY created_at DESC NULLS LAST
  LIMIT 5 OFFSET :offset
  ) as r, reviews.users as u,  (SELECT review_id, array_agg(link) AS photos
    FROM reviews.photos
    WHERE reviews.photos.product_id = :product_id
    GROUP BY review_id) as p
  WHERE r.user_id = u.user_id AND r.review_id = p.review_id;
END;

-- explain (analyze, buffers) SELECT *,
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

-- explain (analyze, buffers) SELECT *
--   FROM
--   (SELECT *
--   FROM reviews.reviews
--   WHERE product_id = 37777
--   ORDER BY created_at DESC NULLS LAST
--   LIMIT 5 OFFSET 100
--   ) as r, reviews.users as u,  (SELECT review_id, array_agg(link) AS photos
--     FROM reviews.photos
--     WHERE reviews.photos.product_id = 37777
--     GROUP BY review_id) as p
--   WHERE r.user_id = u.user_id AND r.review_id = p.review_id;

-- explain (analyze, buffers, format json) SELECT *
  -- FROM reviews.reviews
  -- WHERE product_id = 44444
  -- ORDER BY created_at DESC NULLS LAST;