const { Pool } = require('pg');

// pool by default has 10 clients
const pool = new Pool({
  user: 'postgres',
  password: 'postgres',
  host: '18.188.95.246',
  port: 5432,
  database: 'postgres',
  max: 30,
});

const connect = (name, text, values, cb) => {
  pool.connect((err, client, done) => {
    if (err) throw err;
    client.query({
      name,
      text,
    }, values, (err, res) => {
      done();

      if (err) {
        cb(err.stack);
      } else {
        cb(null, res.rows);
      }
    });
  });
};

const getReviews = (productId, offset, cb) => {
  const name = 'reviewplan';
  const text = `WITH reviews AS (
                  SELECT review_id AS id, user_id, title, text, recommends, reviews.mapRating(rating_overall) AS rating_overall, is_helpful, is_not_helpful, created_at
                  FROM reviews.reviews
                  WHERE product_id = $1
                  ORDER BY created_at DESC NULLS LAST LIMIT 5 OFFSET $2
                )
                SELECT r.*, u.nickname, u.verified,
                (
                  SELECT array_agg(link) AS links
                    FROM reviews.photos
                    WHERE review_id = r.id
                    GROUP BY review_id
                )
                FROM reviews AS r JOIN
                reviews.users AS u USING (user_id)`;
  const values = [productId, offset];
  connect(name, text, values, cb);
};

const createReview = (review, cb) => {
  const name = 'createplan';
  const text = 'SELECT reviews.createReview($1::jsonb)';
  const values = [review];
  connect(name, text, values, cb);
};

const getProduct = (productId, cb) => {
  const name = 'productPlan';
  const text = 'SELECT * FROM reviews.products WHERE product_id = $1';
  const values = [productId];
  connect(name, text, values, cb);
};

module.exports = {
  getProduct,
  getReviews,
  createReview,
};
