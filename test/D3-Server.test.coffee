require 'fluentnode'


D3_Server = require '../src/D3-Server'

describe 'D3-Server', ->


  it 'constructor', ->
    D3_Server.assert_Is_Function()
    using new D3_Server(), ->
      assert_Is_Null @.server
      @.port.assert_Is 3000

  it 'start_Server', ->
    using new D3_Server(), ->
      @.setup_Server()
      @.app.assert_Is_Object
      (@.server is null).assert_Is_True()

  it 'start_Server', (done)->
    using new D3_Server(), ->
      @.port = 1000 + 3000.random()
      @.setup_Server()
      @.start_Server()
      @.app.assert_Is_Function()
      @.server.assert_Is_Object()
      @.server_Url().add('/ping').GET (data)=>
        data.assert_Is 'pong'
        @.server_Url().GET (data)->
          data.assert_Contains '<g><circle cx="50"'
          done()

  it 'route_Main', ->
    using new D3_Server(), ->
      @.setup_Server()
      req =
        app  : @.app
      res =
        render: (target, data)->
          target.assert_Is 'index'
          target.assert_Is 'index'
          data.svgstuff.assert_Contains '<g><circle cx="50"'
      @.route_Main req, res

  it 'server_Url', ->
    using new D3_Server(), ->
      @.server_Url().assert_Is 'http://localhost:3000'
      @.port = 12345
      @.server_Url().assert_Is 'http://localhost:12345'
      
      