-- use cases
-- 100k products
-- ~200 reviews/ products -- 0(min), 5000(max), 100(avg)
-- 10M users
-- 30M records total
-- read is prioritized
-- write can have a 48hr delay
-- update/delete can be slow as well
-- load reviews in increments of 5

CREATE KEYSPACE IF NOT EXISTS reviews
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
-- NetworkTopologyStrategy
-- 5 nodes(instances)
-- bottleneck

USE reviews;

CREATE TABLE IF NOT EXISTS reviews.users (
  user_id int, -- uuid or counter
  nickname text,
  email text,
  verified boolean,
  PRIMARY KEY ((user_id)));

CREATE TABLE IF NOT EXISTS reviews.product_names_to_id (
  product_name text,
  product_id int,
  PRIMARY KEY((product_name))
);

CREATE TABLE IF NOT EXISTS reviews.products (
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

CREATE TABLE IF NOT EXISTS reviews.reviews_by_product (
  review_id int,
  product_id int,
  user_id int,
  nickname text,
  verified boolean,
  created_at timestamp,
  photos set<text>, -- maybe create a photos, is best practice
  title text,
  text text,
  recommends boolean,
  rating_overall text,
  rating_size text,
  rating_width text,
  rating_comfort text,
  rating_quality text,
  is_helpful smallint,
  is_not_helpful smallint,
  PRIMARY KEY ((product_id), created_at, user_id)
) WITH CLUSTERING ORDER BY (created_at DESC);


COPY users (user_id, nickname, email, verified) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/user/seed_user1.csv';
COPY products (product_id, product_name) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/product/seed_product1.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review10.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review9.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review8.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review7.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review6.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review5.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review4.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review3.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review2.csv';
COPY reviews.reviews_by_product (review_id, product_id, user_id, title, text, recommends, rating_overall, rating_size, rating_width, rating_comfort, rating_quality, is_helpful, is_not_helpful, created_at) FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review1.csv';