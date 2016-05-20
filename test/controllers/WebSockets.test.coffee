WebSocket   = require('ws')
Web_Sockets = require '../../src/server/Web-Sockets'

describe 'WebSockets', ->
  web_Sockets = null

  beforeEach ->
    web_Sockets = new Web_Sockets()

  it 'constructor', ->
    using web_Sockets, ->
      @.options.assert_Is {}
      @.port.assert_Is_Bigger_Than 20000
      assert_Is_Null @.ws_Server

  it 'start_Server', (done)->
    using web_Sockets, ->
      @.start_Server()
      @.ws_Server.assert_Is_Object()

      ws = new WebSocket @.server_Url()
      ws.on 'open', ()->
        console.log  'on open'
        ws.send 'from client'
        done()
      ws.on 'message', (message)->
        console.log message

  it 'server_Url', ->
    using web_Sockets, ->
      @.server_Url().assert_Is "ws://localhost:#{@.port}"