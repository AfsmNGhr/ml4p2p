;(function() {
  'use strict';

  var deps = [
    'ngMaterial',
    'infinite-scroll'
  ];

  config.$inject = ['$mdThemingProvider'];
  function config($mdThemingProvider) {
    $mdThemingProvider.theme('default')
      .primaryPalette('pink')
      .accentPalette('light-blue');
  }

  run.$inject = [];
  function run() {
  }

  angular.module('Torrent', deps)
    .config(config)
    .run(run);
})();

angular.module('infinite-scroll').
  value('THROTTLE_MILLISECONDS', 500);

//= ./controllers/film.js
//= ./services/film.js
