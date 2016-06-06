
describe 'angular | An-Controller', ->

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $compile)->      
      $scope = $rootScope.$new()
      console.log $scope
    

  it 'constructor',->

    console.log 'will test controller here'