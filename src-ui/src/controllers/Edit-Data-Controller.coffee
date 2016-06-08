angular.module('MM_Graph')
  .controller 'EditDataController', ($scope, $routeParams,  MM_Graph_API)->
    target = $routeParams.target

    $scope.save_Data = ()->
      #$scope.status = 'saving data ....'
      MM_Graph_API.file_Save $scope.target, $scope.data, (result)->
        $scope.status = result


    if target
      $scope.status = 'loading team data'
      $scope.target = target
      MM_Graph_API.file_Get target, (data)->
        $scope.status = 'data loaded'
        $scope.data_Raw     = JSON.stringify(data, null, 4)
        $scope.data         = data
        $scope.metadata     = data.metadata
        $scope.governance   = $scope.data?.activities?.Governance
        $scope.intelligence = $scope.data?.activities?.Intelligence
        $scope.ssdl         = $scope.data?.activities?.SSDL
        $scope.deployment   = $scope.data?.activities?.Deployment

    else
      $scope.status = 'No team provided'

