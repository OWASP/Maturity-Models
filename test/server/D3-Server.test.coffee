

D3_Server = require '../../src/server/D3-Server'

describe 'D3-Server', ->

  d3_Server = null

  beforeEach ->
    d3_Server = new D3_Server()

  afterEach (done)->
    if d3_Server.server
      d3_Server.stop ->
        done()
    else
      done()


  it 'constructor', ->
    expected_Port = process.env.PORT || 3000
    D3_Server.assert_Is_Function()
    using new D3_Server(), ->
      assert_Is_Null @.server
      @.port.assert_Is expected_Port

  it 'constructor (with options)', ->
    port = 12345
    using new D3_Server(port:port), ->
      @.port.assert_Is 12345

  it 'start_Server', ->
    using new D3_Server(), ->
      @.setup_Server()
      @.app.assert_Is_Object
      (@.server is null).assert_Is_True()

  it 'start_Server', (done)->
    using d3_Server, ->
      @.port = 1000 + 3000.random()
      @.setup_Server()
      @.start_Server()
      @.app.assert_Is_Function()
      @.server.assert_Is_Object()
      @.server_Url().add('/ping').GET (data)=>
        data.assert_Is 'pong'
        done()

  it 'add_Bower_Support', (done)->
    using d3_Server, ->
      @.port = 1000 + 3000.random()
      @.setup_Server()
      @.add_Bower_Support()
      @.start_Server()
      @.server_Url().add('/lib/jquery/dist/jquery.js').GET (data)=>
        data.assert_Contains 'jQuery JavaScript Library v2.2.3'
        done()

  it 'route_Main', ->
    using d3_Server, ->
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
    using d3_Server, ->
      expected_Port = process.env.PORT || 3000
      @.server_Url().assert_Is "http://localhost:#{expected_Port}"
      @.port = 12345
      @.server_Url().assert_Is 'http://localhost:12345'

  it 'run', (done)->
    using d3_Server, ->
      @.run(true)
      @.port.assert_Is_Not 3000
      @.server_Url().GET (data)=>
        data.assert_Is 'Found. Redirecting to d3-radar'
        done()

  it 'stop', (done)->
    using d3_Server, ->
      @.run(true)
      @.stop =>
        @.server_Url().GET (data)=>
          assert_Is_Null data
          done()