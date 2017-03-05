var express = require('express');
var app = express();
var ua = require('universal-analytics');
var cookieSession = require('cookie-session');
const pathUtil = require('path');
const _ = require('underscore');

module.exports = function (elmer_versions) {

  var sendAnalyticsEvent = function (req, category, action) {
    req.visitor.event(category, action).send();
  }

  var sendPageView = function (req, path) {
    req.visitor.pageview(path).send();
  }

  var staticPagePath = function(fullPath) {
    var delim = "/public";
    var start = fullPath.indexOf(delim)
    return fullPath.substr(start + delim.length);
  }

  app.use(cookieSession({
    name: 'elmer-test-session',
    keys: ['dfsdkhfdsjk7868', 'hsdh535vjsbd7s']
  }))

  app.use(ua.middleware("UA-92414229-1", {cookieName: '_ga'}));

  app.use("/packages", function(req, res, next) {
    if (pathUtil.extname(req.path) == '') {
      sendPageView(req, req.path);
    }
    next();
  });

  app.use("/downloads", function(req, res, next) {
    sendAnalyticsEvent(req, "Download", pathUtil.basename(req.path));
    next();
  });

  app.use(express.static('public', { setHeaders: function (response, path, stat) {
      if (pathUtil.extname(path) == '') {
        response.set('Content-Type', 'text/html');
      }
    }
  }));

  app.get('/packages/brian-watkins/elmer/latest', function(req, res, next) {
    var latest = _.last(elmer_versions[0].versions)
    res.redirect(`/packages/brian-watkins/elmer/${latest}`);
  });

  app.get('/description', function (req, res, next) {
    sendAnalyticsEvent(req, "Install", `${req.query.name}/${req.query.version}`);

    if (req.query.name == "brian-watkins/elmer" && req.query.version) {
      res.redirect(`/versions/${req.query.version}/elm-package.json`);
    } else {
      res.status(404).send(`Unknown package: ${req.query.name} (${req.query.version})`);
    }
  });

  app.get('/all-packages', function (req, res, next) {
    sendAnalyticsEvent(req, "Install", "versions")

    res.json(elmer_versions)
  });

  return app;
}
