//require('newrelic');
const express = require('express');
const compression = require('compression');
const bodyParser = require('body-parser');
const path = require('path');
const { getProduct, getReviews, createReview } = require('../db');
const redis = require('redis');
const { promisify } = require('util');

const client = redis.createClient();//'/tmp/redis.sock'
const get = promisify(client.get).bind(client);

const app = express();
const PORT = 3003;

app.use(bodyParser.json());
app.use(compression());

app.use(express.static('./client/dist'));

app.get(`/api/product/:product_id`, (req, res) => {
  const { product_id } = req.params;

  get(`primary-${product_id}`)
  .then(cache => {
    if (cache === null) {
      getProduct(product_id, (err, result) => {
        if (err) {
          console.log(err);
          res.sendStatus(404)
        } else {
          //client.set(`primary-${product_id}`, JSON.stringify(result));
          res.set('Cache-Control', 'public, max-age=604800');
          res.set('Content-Type', 'application/json');
          res.send(result);
        }
      });
    } else {
      res.set('Cache-Control', 'public, max-age=604800');
      res.set('Content-Type', 'application/json');
      res.send(cache);
    }
 })
 .catch(err => res.sendStatus(404));
});

app.get(`/api/product/:product_id/review`, (req, res) => {
  const { product_id } = req.params;

  get(product_id)
  .then(cache => {
    if (cache === null) {
      getReviews(product_id, 0, (err, result) => {
        if (err) {
          console.log(err);
          res.sendStatus(404)
        } else {
          //client.set(product_id, JSON.stringify(result));
          res.set('Cache-Control', 'public, max-age=604800');
          res.set('Content-Type', 'application/json');
          res.send(result);
        }
      });
    } else {
      res.set('Cache-Control', 'public, max-age=604800');
      res.set('Content-Type', 'application/json');
      res.send(cache);
    }
  })
  .catch(err => res.sendStatus(404));
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

app.get('/test', (req, res) =>  res.send());

app.listen(PORT, () => console.log('Listening on port', PORT));
