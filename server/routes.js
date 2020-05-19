var controller = require('./controllers');
var router = require('express').Router();

router.get('/:productcode/reviews', controller.reviews.get);

router.post('/:productcode/reviews', controller.reviews.post);

router.get('/users', controller.users.get);

router.post('/users', controller.users.post);

module.exports = router;

