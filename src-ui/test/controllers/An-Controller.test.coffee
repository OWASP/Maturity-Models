
describe 'angular | An-Controller', ->

  scope = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      $controller('AnController', { $scope: scope })

  it 'constructor',->

    expect(scope.test).to.equal '12345..'