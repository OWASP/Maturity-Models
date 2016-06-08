describe '| angular | views | angular-page', ->

  #element = null
  
  beforeEach ()->
    module('MM_Graph')

  it 'angular-page.html',->
    inject ($templateCache)->
      html = $templateCache.get('angular-page.html')
      element = angular.element(html)

      expect(element[0].tagName).to.equal 'META'
      expect(element[0].attributes[0].name).to.equal 'charset'
      expect(element[0].attributes[0].value).to.equal 'utf-8'

      expect(element[1].tagName).to.equal 'META'
      expect(element[1].attributes[0].name).to.equal 'name'
      expect(element[1].attributes[0].value).to.equal 'viewport'
      expect(element[1].attributes[1].name).to.equal 'content'
      expect(element[1].attributes[1].value).to.equal 'width=device-width'

      expect(element[2].tagName).to.equal 'LINK'
      expect(element[2].rel    ).to.equal 'stylesheet'
      expect(element[2].href   ).to.contain '/lib/foundation/css/foundation.min.css'

      expect(element[3].tagName).to.equal 'SCRIPT'
      expect(element[3].src    ).to.contain '/lib/angular/angular.js'

      expect(element[4].tagName).to.equal 'SCRIPT'
      expect(element[4].src    ).to.contain '/lib/angular-route/angular-route.js'
      
      expect(element[5].tagName).to.equal 'SCRIPT'
      expect(element[5].src    ).to.contain '/ui/js/angular-src.js'

      #expect(element[5].tagName).to.equal 'SCRIPT'
      #expect(element[5].src    ).to.contain '/lib/foundation/js/foundation.js'


  # todo: rewrite this using better selectors
  xit 'routes.html',->
    inject ($templateCache)->
      html = $templateCache.get('routes.html')
      element = angular.element(html)
      expect(element[6].tagName).to.equal('DIV')
      expect(element[6].attributes[0].name ).to.equal 'ng-controller'
      expect(element[6].attributes[0].value).to.equal 'RoutesController'


    inject ($rootScope, $compile, $templateCache, $httpBackend)->
      test_Data = ['/','/b']
      $httpBackend.expectGET('/api/v1/routes/list').respond test_Data
      html     =  $templateCache.get('routes.html')
      element  = angular.element html
      $compile(element)($rootScope)
      $rootScope.$apply();

      expect(element[6].innerText).to.equal 'Available routes'           # before the flush
      $httpBackend.flush()
      expect(element[6].innerText).to.equal 'Available routes["/","/b"]' # after the flush


      routesId = angular.element(element[6])
      routesId.find('div')[2].innerText.assert_Is JSON.stringify(test_Data)

      
