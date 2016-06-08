angular.module('MM_Graph')
  .controller 'TeamsController', ($scope, MM_Graph_API)->
    MM_Graph_API.file_List (data)->
      teams = (name for name in data when name.contains('team'))
      $scope.teams = teams

