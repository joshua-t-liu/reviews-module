var mysql = require('mysql');
var mysqlConfig = require('./config.js');

var connection = mysql.createConnection(mysqlConfig);

connection.connect((err) => {
  if (err) {
    console.error('error connecting: ', err.stack);
    return;
  }
  console.log('mySQL connected as id', connection.threadId);
});

module.exports = connection;