angular.module('MM_Graph')
  .config ($routeProvider)->
    $routeProvider
      .when '/',
        controller: 'AnController',
        templateUrl:'test.html',

    console.log 'routes added'
