var express = require('express');
var app = express();
const pathUtil = require('path');

module.exports = function (elmer_versions) {

  app.use(express.static('public', { setHeaders: function (res, path, stat) {
      if (pathUtil.extname(path) == '') {
        res.set('Content-Type', 'text/html');        
      }
    }
  }));

  app.get('/description', function (req, res, next) {
    if (req.query.name == "brian-watkins/elmer" && req.query.version) {
      res.redirect(`/versions/${req.query.version}/elm-package.json`);
    } else {
      res.status(404).send(`Unknown package: ${req.query.name} (${req.query.version})`);
    }
  });

  app.get('/all-packages', function (req, res, next) {
    res.json(elmer_versions)
  });

  return app;
}
