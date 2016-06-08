angular.module('MM_Graph')
  .controller 'RoutesController', ($scope, MM_Graph_API)->
    MM_Graph_API.routes (data)->
      $scope.routes = data