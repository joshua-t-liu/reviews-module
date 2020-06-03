require('newrelic');
const express = require('express');
const compression = require('compression');
const bodyParser = require('body-parser');
const path = require('path');
const { getProduct, getReviews, createReview } = require('../db');

const app = express();
const PORT = 3003;

app.use(bodyParser.json());
app.use(compression());

const options = {
  maxAge: '1d',
  setHeaders: (res, path) => { res.set('Cache-Control', 'public, max-age=604800') },
};

app.use(express.static(path.join(__dirname, '../client', 'dist'), options));

app.get(`/api/product/:product_id`, (req, res) => {
  const { product_id } = req.params;
  getProduct(product_id, (err, result) => {
    if (err) {
      console.log(err);
      res.sendStatus(404)
    } else {
      res.set('Cache-Control', 'public, max-age=604800');
      res.send(result);
    }
  });
});

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
