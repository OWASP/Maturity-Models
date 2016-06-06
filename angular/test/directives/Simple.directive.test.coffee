describe '| directive | simple', ->

  element = null
  $scope  = null

  beforeEach ()->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $compile, $templateCache)->
      $templateCache.put('directive.html', $templateCache.get('simple.html'));
      template = angular.element '<simple/>'
      $scope = $rootScope.$new();
      $compile(template)($scope);
      $scope.$apply();
      element = template

  it '<simple/>',->
    value = 'abc 123'
    $scope.test = value
    $scope.$apply()
    expect(element.find('p').html()).to.equal value
    expect(element.find('hr').length).to.equal 1
    
