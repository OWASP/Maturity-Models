Redirects = require '../../src/server/Redirects'
Server    = require '../../src/server/Server'
  
describe 'server | Redirects', ->

  app    = null
  server = null
  
  beforeEach ->
    server = new Server().setup_Server()
    app    = server.app

  it 'constructor', ->    
    using new Redirects(), ->
      @.constructor.name.assert_Is 'Redirects'
      
  it 'add_Redirects', ->
    using new Redirects(app:app), ->
      @.add_Redirects()
      server.routes().assert_Is [ '/ping', '/', ]