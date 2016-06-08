app = angular.module('MM_Graph')

app.directive  'activitytable', ()->
  #controller: 'EditDataController'
  restrict: 'E',
  scope:
    title: '=title'
    data : '=data'
  templateUrl: '/ui/html/directives/activity-table.html'
