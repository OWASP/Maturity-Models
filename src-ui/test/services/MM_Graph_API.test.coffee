describe '| services | MM_Graph_API', ->

  mm_Graph_API  = null

  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      mm_Graph_API = $injector.get('MM_Graph_API')

  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'routes', ->
    using mm_Graph_API, ->
      check_Are_Functions =  (names)=>
        for name in names
          #console.log name
          expect(@[name]  ).to.be.an 'function'

      check_Are_Functions ['routes']



  it 'routes', ()->    
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/routes/list').respond ['/','/b']
      using mm_Graph_API, ->
        @.routes (data)->
          data.assert_Is ['/','/b']
        $httpBackend.flush()
        