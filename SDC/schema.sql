-- use cases
-- 100k products
-- ~200 reviews/ products -- 0(min), 5000(max), 100(avg)
-- 10M users
-- 30M records total
-- read is prioritized
-- write can have a 48hr delay
-- update/delete can be slow as well
-- load reviews in increments of 5

CREATE SCHEMA IF NOT EXISTS reviews;

CREATE TABLE IF NOT EXISTS reviews.products (
  product_id serial primary key,
  product_name varchar(255) not null
  recommends numeric(3,0) DEFAULT 0;
  review_count smallint DEFAULT 0,
  rating_overall numeric(3,2) DEFAULT 0.0,
  rating_size numeric(3,2) DEFAULT 0.0,
  rating_width numeric(3,2) DEFAULT 0.0,
  rating_comfort numeric(3,2) DEFAULT 0.0,
  rating_quality numeric(3,2) DEFAULT 0.0,
  count_5 smallint DEFAULT 0,
  count_4 smallint DEFAULT 0,
  count_3 smallint DEFAULT 0,
  count_2 smallint DEFAULT 0,
  count_1 smallint DEFAULT 0
);

CREATE INDEX product_name_index ON reviews.products(product_name);

CREATE TABLE IF NOT EXISTS reviews.users (
  user_id serial,
  nickname varchar(25) not null,
  email varchar(255) not null,
  verified boolean DEFAULT false,
  PRIMARY KEY (user_id) INCLUDE (nickname, verified)
);

CREATE TYPE rating AS ENUM ('poor', 'fair', 'average', 'good', 'great');

CREATE TABLE IF NOT EXISTS reviews.ratings (
  rating rating not null,
  score smallint not null
);

INSERT INTO reviews.ratings (rating, score) VALUES
  ('poor', 1),
  ('fair', 2),
  ('average', 3),
  ('good', 4),
  ('great', 5);

CREATE TYPE ratings_centered AS ENUM ('too_small', 'small', 'perfect', 'big', 'too_big');

CREATE TABLE IF NOT EXISTS reviews.ratings_centered (
  ratings_centered ratings_centered not null,
  score smallint not null
);

INSERT INTO reviews.ratings_centered (ratings_centered, score) VALUES
  ('too_small', 1),
  ('small', 2),
  ('perfect', 3),
  ('big', 4),
  ('too_big', 5);

CREATE TABLE IF NOT EXISTS reviews.reviews (
  review_id serial primary key,
  product_id integer not null,
  user_id integer,
  title varchar(150),
  text text not null,
  recommends boolean not null,
  rating_overall rating not null,
  rating_size ratings_centered not null,
  rating_width ratings_centered not null,
  rating_comfort rating not null,
  rating_quality rating not null,
  is_helpful smallint DEFAULT 0,
  is_not_helpful smallint DEFAULT 0,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
  --UNIQUE (product_id, user_id)
);

CREATE TABLE IF NOT EXISTS reviews.photos (
  photo_id serial primary key,
  review_id integer not null references reviews.reviews(review_id),
  product_id int not null references reviews.products(product_id),
  link varchar(255) not null
);

CREATE INDEX review_id_index ON reviews.photos (review_id) INCLUDE (link);

PREPARE reviewplan (int, int, int) AS
  SELECT *,
    (SELECT array_agg(link) AS photos
      FROM reviews.photos
      WHERE reviews.photos.review_id = r.review_id)
    FROM reviews.reviews as r, reviews.users as u
    WHERE r.user_id = u.user_id and r.product_id = $1
    ORDER BY r.created_at DESC NULLS LAST
    LIMIT $2 OFFSET $3;

COPY reviews.users FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module/SDC/user/seed_user1.csv' WITH (FORMAT csv);
COPY reviews.products FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module/SDC/product/seed_product1.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review10.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review9.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review8.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review7.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review6.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review5.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review4.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review3.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review2.csv' WITH (FORMAT csv);
COPY reviews.reviews FROM '/mnt/c/users/joshua/Desktop/SDC/reviews-module//SDC/review/seed_review1.csv' WITH (FORMAT csv);