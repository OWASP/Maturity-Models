WebSocket       = require('ws')
WebSocketServer = WebSocket.Server

class Web_Sockets

  constructor: (options)->
    @.options   = options || {}
    @.port      = @.options.port || 20000.add(20000.random())
    @.ws_Server = null
    
  start_Server: ()=>
    @.ws_Server = new WebSocketServer({ port: @.port });
    @.ws_Server.on 'connection', (ws)->
      console.log 'on connection'
      ws.on 'message', (message)-> 
        console.log 'on message: ' + message
        
      ws.send 'from server'

  server_Url: ()=>
    "ws://localhost:#{@.port}"
    
module.exports = Web_Sockets
