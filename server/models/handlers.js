module.exports = {
  genericQueryHandler: (res) => {
    return (
      (err, results, fields) => {
        if (err) {
          console.log('query error');
          console.error(err);
          res.status(500).send(err);
        } else {
          res.status(200).send(results);
        }
      }
    );
  }, 
  cbQueryHandler: (callback) => {
    return (
      (err, results, fields) => {
        if (err) {
          console.log('query error');
          console.error(err);
          callback(err, results);
        } else {
          callback(null, results);
        }
      }
    );
  }
};