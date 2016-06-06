
describe 'angular | RoutesController', ->

  scope = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      $controller('RoutesController', { $scope: scope })

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/routes/list').respond ['/','/b']
      $httpBackend.flush()
      scope.routes.assert_Is ['/','/b']