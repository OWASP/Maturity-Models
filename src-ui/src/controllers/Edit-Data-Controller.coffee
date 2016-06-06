angular.module('MM_Graph')
  .controller 'EditDataController', ($scope, $location, MM_Graph_API)->

    target = $location.search().team

    $scope.save_Data = ()->
      $scope.status = 'saving data ....'
      MM_Graph_API.file_Save $scope.target, $scope.data, (result)->
        $scope.status = 'save result ' + result

    if target
      $scope.status = 'loading team data'
      $scope.target = target
      MM_Graph_API.file_Get target, (data)->
        $scope.status = 'data loaded'
        $scope.data   = JSON.stringify(data, null, 4)
    else
      $scope.status = 'No team provided'


