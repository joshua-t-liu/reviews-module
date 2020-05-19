module.exports = {
  httpRequestLogger: (req, res, next) => {
    if ((Object.keys(req.body)).length > 0) {
      console.log(req.method, req.path, 'body:', req.body);
    } else {
      console.log(req.method, req.path);
    }
    next();
  }
};