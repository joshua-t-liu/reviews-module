-- use cases
-- 100k products
-- ~200 reviews/ products -- 0(min), 5000(max), 100(avg)
-- 10M users
-- 30M records total
-- read is prioritized
-- write can have a 48hr delay
-- update/delete can be slow as well
-- load reviews in increments of 5

CREATE KEYSPACE IF NOT EXIST reviews
  WITH replication = {'class': 'NetworkTopologyStrategy', 'replcation_factor': 1};

CREATE TABLE IF NOT EXIST reviews.users (
  user_id int,
  nickname text,
  email text,
  verified boolean,
  PRIMARY KEY ((user_id)));

CREATE TABLE IF NOT EXIST reviews.product_names_to_id (
  product_name text,
  product_id int
  PRIMARY KEY((product_name))
);

CREATE TABLE IF NOT EXIST reviews.products (
  product_id int,
  product_name text,
  review_count smallint,
  rating_overall float,
  rating_size float,
  rating_width float,
  rating_comfort float,
  rating_quality float,
  count_5 smallint,
  count_4 smallint,
  count_3 smallint,
  count_2 smallint,
  count_1 smallint,
  PRIMARY KEY((product_id))
);

-- CREATE INDEX IF NOT EXIST name_index ON reviews.products (product_name);
-- indexing name is not helpful for search because query is partitioned by id already ???

CREATE TABLE IF NOT EXIST reviews.reviews_by_product (
  product_id int,
  user_id int,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP,
  photos set<text>,
  title text,
  text text,
  recommends boolean,
  rating_overall smallint,
  rating_size smallint,
  rating_width smallint,
  rating_comfort smallint,
  rating_quality smallint,
  is_helpful smallint DEFAULT 0,
  is_not_helpful smallint DEFAULT 0,
  PRIMARY KEY ((product_id), created_at))
  AND CLUSTERING ORDER BY (created_at DESC);

--SELECT * FROM reviews.reviews_by_product WHERE product_id = 199;