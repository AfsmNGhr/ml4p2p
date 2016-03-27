;(function(angular){
  'use strict';

  filmService.$inject = ['$http'];

  function filmService($http) {
    this.getFilms = function(page) {
      var params = page ? '?page=' + page : '';
      return $http.get('http://localhost:3000/films' + params);
    };
  }

  angular.module('Torrent')
    .service('filmService', filmService);
})(window.angular);
