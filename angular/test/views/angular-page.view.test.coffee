describe '| angular | views | angular-page', ->

  element = null
  $scope  = null

  beforeEach ()->
    module('MM_Graph')

  it 'angular-page',->
    inject ($templateCache)->
      html = $templateCache.get('angular-page.html')
      element = angular.element(html)
      expect(element[0].tagName).to.equal 'SCRIPT'
      expect(element[0].src    ).to.contain '/lib/angular/angular.js'
      expect(element[1].tagName).to.equal 'SCRIPT'
      expect(element[1].src    ).to.contain '/angular/js/angular-src.js'


    
