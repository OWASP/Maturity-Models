Server = require '../../src/server/Server'

describe 'server | Server', ->

  server = null

  beforeEach ->
    server = new Server()

  afterEach (done)->
    if server.server
      server.stop ->
        done()
    else
      done()


  it 'constructor', ->
    expected_Port = process.env.PORT || 3000
    Server.assert_Is_Function()
    using new Server(), ->
      assert_Is_Null @.server
      assert_Is_Null @.app
      @.options.assert_Is {}
      @.port.assert_Is expected_Port

  it 'constructor (with options)', ->
    port = 12345
    using new Server(port:port), ->
      @.port.assert_Is 12345

  it 'start_Server', ->
    using new Server(), ->
      @.setup_Server()
      @.app.assert_Is_Object
      (@.server is null).assert_Is_True()

  it 'start_Server', (done)->
    using server, ->
      @.port = 20000 + 5000.random()
      @.setup_Server()
      @.start_Server()
      @.app.assert_Is_Function()
      @.server.assert_Is_Object()
      @.server_Url().add('/ping').GET (data)=>
        data.assert_Is 'pong'
        done()

  it 'add_Bower_Support', (done)->
    using server, ->
      @.port = 2000 + 5000.random()
      @.setup_Server()
      @.add_Bower_Support()
      @.start_Server()
      @.server_Url().add('/lib/jquery/dist/jquery.js').GET (data)=>
        data.assert_Contains 'jQuery JavaScript Library v2.2.4'
        done()

  it 'add_Controllers', -> 
    using server, ->
      @.setup_Server()
      @.add_Controllers()
      @.routes().assert_Size_Is 17
      @

  it 'add_Redirects', ->
    using server, ->
      @.setup_Server()
      @.add_Redirects()
      @.routes().assert_Size_Is 6
      @

  it 'route_Main', ->
    using server, ->
      @.setup_Server()
      req =
        app  : @.app
      res =
        render: (target, data)->
          target.assert_Is 'index'
          target.assert_Is 'index'
          data.svgstuff.assert_Contains '<g><circle cx="50"'
      @.route_Main req, res

  it 'setup_Logging', ->
    using server, ->
      @.setup_Server()
      @.setup_Logging()
      @.logs_Stream.assert_Is_Object()                # note: not sure how to test this better, neet to look at how morgan stream works
      @.logs_Morgan.assert_Is_Function()

  it 'server_Url', ->
    using server, ->
      expected_Port = process.env.PORT || 3000
      @.server_Url().assert_Is "http://localhost:#{expected_Port}"
      @.port = 12345
      @.server_Url().assert_Is 'http://localhost:12345'

  it 'routes', ()->
    using server, ->
      @.setup_Server()
      @.add_Controllers()
      @.add_Redirects()
      #console.log @.routes() 
      @.routes().assert_Is [ '/', '/ping', '/d3-radar', '/live-radar'
                             '/angular', 
                             '/api/v1/logs/path'
                             '/api/v1/logs/list'
                             '/api/v1/logs/file/:index'
                             '/api/v1/file/list'                             
                             '/api/v1/file/get/:filename' , '/api/v1/file/save/:filename'
                             '/api/v1/routes/list'
                             '/view/routes/list'      , '/view/routes/list-raw'
                             '/view/file/list'
                             '/view/:filename/table'  , '/view/:filename/table.json'
                             '/routes']
      
  it 'run', (done)->
    using server, ->
      @.run(true)
      @.port.assert_Is_Not 3000
      @.server_Url().GET (data)=>
        data.assert_Is 'Found. Redirecting to d3-radar'
        done()

  it 'stop', (done)->
    using server, ->
      @.run(true)
      @.stop =>
        @.server_Url().GET (data)=>
          assert_Is_Null data
          done()