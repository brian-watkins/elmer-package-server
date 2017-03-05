
var request = require('supertest');
var server = require('../server');

const fake_elmer_versions = [
  {
    name: "fake-elmer",
    summary: "fake-summary",
    versions: [
      "1.0.0",
      "1.0.1",
      "2.0.0"
    ]
  }
];

var app = server(fake_elmer_versions);

var resolve = function(done, handler) {
  return function(err, res) {

    if (handler) {
      handler(err, res);
    }

    if (err) {
      done.fail(err);
    } else {
       done();
    }
  }
}

describe('GET /description', function() {

  describe('when the name is invalid', function() {
    it('returns 404', function(done) {
      request(app)
        .get('/description?name=blah')
        .expect(404)
        .end(resolve(done));
    });
  });

  describe('when the name is valid', function() {

    describe('when the version is missing', function() {
      it('returns 404', function(done) {
        request(app)
          .get('/description?name=brian-watkins/elmer')
          .expect(404)
          .end(resolve(done));
      });
    })

    describe('when the version is given', function () {
      it('redirects to the proper description', function(done) {
        request(app)
          .get('/description?name=brian-watkins/elmer&version=9.0.2')
          .expect(302)
          .expect('Location', '/versions/9.0.2/elm-package.json')
          .end(resolve(done));
      });
    });

  });

  describe('GET /all-packages', function() {
    it('shows all the version info', function(done) {
      request(app)
        .get('/all-packages')
        .expect(200)
        .end(resolve(done, function(err, res) {
          expect(res.body).toEqual(fake_elmer_versions);
        }));
    });
  });

  describe('GET /packages/brian-watkins/elmer/latest', function() {
    it('redirects to the latest version of the docs', function(done) {
      request(app)
        .get('/packages/brian-watkins/elmer/latest')
        .expect(302)
        .expect('Location', '/packages/brian-watkins/elmer/2.0.0')
        .end(resolve(done));
    })
  });

});
