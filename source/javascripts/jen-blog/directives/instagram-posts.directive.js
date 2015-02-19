(function() {
  'use strict';

  angular.module('jen-blog').directive('instagramPosts', ['instagrams', instagramPosts]);

  function instagramPosts(instagrams) {
    return {
      template: '<li class="instagram-post" ng-repeat="gram in grams | limitTo: limit">' +
                  '<a href="{{ gram.link }}">' +
                    '<img ng-src="{{ gram.images.standard_resolution.url }}" />' +
                  '</a>' +
                '</li>',
      link: link,
    };

    function link(scope, element, attributes) {
      var tag = attributes.tag;
      instagrams.load(tag).then(function(theGrams) {
        scope.grams = theGrams.data;
        scope.limit = attributes.limit;
      });
    };
  };
})();
