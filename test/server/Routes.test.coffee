Routes    = require '../../src/server/Routes'
D3_Server = require '../../src/server/D3-Server'

describe 'server | Routes', ->
  it 'construtor', ->
    using new Routes(app: 'app'),->
      @.options.assert_Is app: 'app'
      @.app.assert_Is 'app'

  it 'list', ->
    using new Routes() , ->
      @.list().assert_Is []

    d3_Server = new D3_Server().setup_Server()  
    using new Routes(app: d3_Server.app) , ->
      @.list().assert_Is 	[ '/', '/ping', '/d3-radar' ]
        
