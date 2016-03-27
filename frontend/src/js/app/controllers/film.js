;(function(angular){
  'use strict';

  filmController.$inject = ['$scope', 'filmService'];

  function filmController($scope, filmService) {
    $scope.params = { firstLoad: true };
    filmService.getFilms().success(function(data) {
      $scope.films = data.films;
      $scope.pages = data.pages;
      $scope.page = data.page;
    });

    $scope.getMoreFilms = function() {
      if (!$scope.params.firstLoad &&
          $scope.films.length >= 30 &&
          $scope.page != $scope.pages) {
        $scope.page += 1;
        filmService.getFilms($scope.page).success(function(data) {
          $scope.films = _.union($scope.films, data.films);
          $scope.pages = data.pages;
          $scope.page = data.page;
        });
      }
      $scope.params.firstLoad = false;
    };
  }

  angular.module('Torrent')
    .controller('filmCtrl', filmController);
})(window.angular);
