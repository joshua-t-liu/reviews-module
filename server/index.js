const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const { getReviews, createReview } = require('../db');

const app = express();
const PORT = 3003;

app.use(express.static(path.join(__dirname, '../client', 'dist')));
app.use(bodyParser.json());

app.get(`/api/product/:product_id/review`, (req, res) => {
  const { product_id } = req.params;
  getReviews(product_id, 0, (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(404)
    } else {
      res.send(result);
    }
  });
});

app.post(`/api/product/:product_id/review`, (req, res) => {
  const { product_id } = req.params;
  const review = req.body;
  review['product_id'] = parseInt(product_id);

  createReview(review, (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(404)
    } else {
      res.send(result);
    }
  });
});

app.listen(PORT, () => console.log('Listening on port', PORT));
