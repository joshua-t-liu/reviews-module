ALTER TABLE reviews.reviews ADD CONSTRAINT prodfk FOREIGN KEY (product_id) REFERENCES reviews.products(product_id);

ALTER TABLE reviews.reviews ADD CONSTRAINT userfk FOREIGN KEY (user_id) REFERENCES reviews.users(user_id);

CREATE INDEX user_id_index ON reviews.reviews(user_id);

CREATE INDEX newest_index ON reviews.reviews(product_id, created_at DESC NULLS LAST);

CREATE INDEX review_id_index ON reviews.photos (review_id) INCLUDE (link);

VACUUM ANALYZE reviews.users;
VACUUM ANALYZE reviews.photos;
-- CLUSTER VERBOSE reviews.reviews USING newest_index;
VACUUM ANALYZE reviews.reviews;