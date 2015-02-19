(function() {
  'use strict';

  angular.module('jen-blog').factory('instagrams', instagrams);

  function instagrams($http, $q) {
    var grams;

    return {
      load: load,
    };

    function load(tag) {
      var deferred = $q.defer();

      if (grams) {
        deferred.resolve(grams);
      } else {
        fetchGrams(deferred, tag);
      }

      return deferred.promise;
    }

    function fetchGrams(deferred, tag) {
      $http.jsonp('https://api.instagram.com/v1/tags/'+ tag +'/media/recent?client_id=7adf5ca2cbda49b7bf52bd58ff3180c4&callback=JSON_CALLBACK').then(function(response) {
        grams = response.data;
        deferred.resolve(grams);
      });
    }
  }
})();
