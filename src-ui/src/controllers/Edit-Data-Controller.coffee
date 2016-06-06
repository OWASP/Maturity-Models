angular.module('MM_Graph')
  .controller 'EditDataController', ($scope, $location, MM_Graph_API)->

    target = $location.search().team

    $scope.save_Data = ()->
      $scope.status = 'saving data ....'
      MM_Graph_API.file_Save $scope.target, $scope.data, (result)->
        $scope.status = 'save result ' + JSON.stringify(result)

    if target
      $scope.status = 'loading team data'
      $scope.target = target
      MM_Graph_API.file_Get target, (data)->
        $scope.status = 'data loaded'
        #$scope.data        = JSON.stringify(data, null, 4)
        $scope.data         = data
        
        $scope.governance   = $scope.data?.activities?.Governance
        $scope.intelligence = $scope.data?.activities?.Intelligence
        $scope.ssdl         = $scope.data?.activities?.Governance
        $scope.deployment   = $scope.data?.activities?.SSDL
        
        
    else
      $scope.status = 'No team provided'


