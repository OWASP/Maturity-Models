#to be deleted
describe '| directive | activity-table', ->

  element = null
  $scope  = null

  beforeEach ()->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $compile, $templateCache)->
      $templateCache.put('/ui/html/directives/activity-table.html', $templateCache.get('directives/activity-table.html'));
      template = angular.element '<activityTable/>'
      $scope = $rootScope.$new();
      $compile(template)($scope);
      $scope.$apply();
      element = template

  it '<simple/>',->
    element.find('style').text().assert_Contains 'panel.callout'
    
