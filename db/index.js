const { Pool } = require('pg');

// pool by default has 10 clients
const pool = new Pool({
  user: 'example',
  password: 'example',
  host: 'localhost',
  port: 5432,
  database: 'postgres'
});

const getReviews = (productId, offset, cb) => {
  pool.connect((err, client, done) => {
    if (err) throw err;
    client.query({
      name: 'reviewplan',
      text:
        `WITH reviews AS (
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
          reviews.users AS u USING (user_id)`,
    }, [productId, offset], (err, res) => {
      done();

      if (err) {
        cb(err.stack);
      } else {
        cb(null, res.rows);
      }
    });
  });
};

const createReview = (review, cb) => {
  pool.connect((err, client, done) => {
    if (err) throw err.stack;
    const { nickname, email, ... review_info } = review;

    client.query({
      name: 'createplan',
      text: 'SELECT reviews.createReview($1::reviews.users, $2::jsonb)',
    }, [`(0, ${nickname}, ${email}, false)`, review], (err, res) => {
      done();

      if (err) {
        cb(err.stack);
      } else {
        cb(null, res.rows);
      }
    });
  });
};

module.exports = {
  getReviews,
  createReview,
};