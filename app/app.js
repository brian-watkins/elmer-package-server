'use strict';

var server = require('./server');
var port = process.env.PORT || 9000;

const elmer_versions = [
  {
    "name": "brian-watkins/elmer",
    "summary": "BDD for Elm",
    "versions": [
      "1.0.0"
    ]
  }
];

var app = server(elmer_versions);

app.listen(port, function () {
  console.log('Elmer Package Server running on port %d', port);
});