angular.module('MM_Graph')
  .controller 'ViewDataController', ($scope, $location, MM_Graph_API)->
    #MM_Graph_API.routes (data)->
    #  $scope.routes = data

    $scope.target = $location.search().team

