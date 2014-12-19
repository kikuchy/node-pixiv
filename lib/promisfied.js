// Generated by CoffeeScript 1.8.0
(function() {
  var Promise, pixiv, prmPixiv;

  pixiv = require("./pixiv");

  Promise = (require("es6-promise")).Promise;

  prmPixiv = {
    createSession: function(userId, password) {
      return new Promise(function(resolve, reject) {
        return pixiv.createSession(userId, password, function(error, session) {
          if (error) {
            reject(error);
          }
          return resolve(session);
        });
      });
    },
    getGrapichWork: function(session, workId) {
      return new Promise(function(resolve, reject) {
        return pixiv.getGrapichWork(session, workId, function(error, work) {
          if (error) {
            reject(error);
          }
          return resolve(work);
        });
      });
    }
  };

  module.exports = prmPixiv;

}).call(this);