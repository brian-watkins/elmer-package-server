var express = require('express');
var app = express();
var ua = require('universal-analytics');
const pathUtil = require('path');

module.exports = function (elmer_versions) {

  var sendAnalyticsEvent = function (category, action) {
    var visitor = ua('UA-92414229-1');
    visitor.event(category, action).send();
  }

  var sendPageView = function (path) {
    var visitor = ua('UA-92414229-1');
    visitor.pageview(path).send();
  }

  var staticPagePath = function(fullPath) {
    var delim = "/public";
    var start = fullPath.indexOf(delim)
    return fullPath.substr(start + delim.length);
  }

  app.use(express.static('public', { setHeaders: function (res, path, stat) {
      if (pathUtil.extname(path) == '') {
        sendPageView(staticPagePath(path));
        res.set('Content-Type', 'text/html');
      } else if (pathUtil.extname(path) == '.gz') {
        sendAnalyticsEvent("Download", pathUtil.basename(path));
      }
    }
  }));

  app.get('/description', function (req, res, next) {
    sendAnalyticsEvent("Install", `${req.query.name}/${req.query.version}`);

    if (req.query.name == "brian-watkins/elmer" && req.query.version) {
      res.redirect(`/versions/${req.query.version}/elm-package.json`);
    } else {
      res.status(404).send(`Unknown package: ${req.query.name} (${req.query.version})`);
    }
  });

  app.get('/all-packages', function (req, res, next) {
    sendAnalyticsEvent("Install", "versions")

    res.json(elmer_versions)
  });

  return app;
}
