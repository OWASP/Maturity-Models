angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_Graph_API)->
    target = $routeParams.target

    if target
      MM_Graph_API.view_Table target, (data)->
        $scope.target = target
        $scope.table = data
