angular.module('MM_Graph')
  .controller 'TableController', ($scope, $location, MM_Graph_API)->
    target = $location.search().team

    if target
      MM_Graph_API.view_Table target, (data)->
        $scope.team = target
        $scope.table = data
