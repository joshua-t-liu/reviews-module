// server flow: index.js -> routes -> controller -> model -> db-mysql
const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const path = require('path');
const cors = require('cors');

const middleware = require('./middleware.js');
const router = require('./routes.js');

const app = express();
const PORT = process.env.REVIEWSPORT || 3003;
app.set('port', PORT);

// app.use(bodyParser.json());
// app.use(morgan('dev'));
app.use(express.json());
app.use(middleware.httpRequestLogger);
app.use(cors());

app.get('/api', (req, res) => {
  console.log('hello inside get route');
  res.send('response sent correctly!');
});

app.use('/api/models', router);

app.use(express.static(path.join(__dirname, '../client', 'dist')));

app.listen(app.get('port'), () =>
  console.log('Listening on port: ' + app.get('port')));
