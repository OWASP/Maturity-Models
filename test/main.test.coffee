start_Server = require '../src/main'

describe 'main', ->

  port      = null
  server = null

  beforeEach (done)->
    port = 20000.add 10000.random()
    using start_Server(port : port), ->
      server = @
      done()

  afterEach (done)->
    server.stop ->
      server.server_Url().GET (data)->
        assert_Is_Null data
        done()

  it 'check start_Server setup', (done)->
    start_Server.assert_Is_Function()

    using server, ->
      @.constructor.name.assert_Is 'Server' 
      @.server_Url().assert_Contains port 
      @.server_Url().GET (data)=>
        data.assert_Is 'Found. Redirecting to /ui/html' 
        done()

  it 'check /ui/html', (done)->
    using server, ->
      @.server_Url().add('/lib/angular/angular.js').GET (html)->
        html.assert_Contains 'AngularJS v1.5'
        done()
