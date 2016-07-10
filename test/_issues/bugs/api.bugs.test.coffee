Server  = require '../../../src/server/Server'
request = require 'supertest'


describe '_regression | api', ->
  server  = null                       # these are tests that use supertest, which mean they need to be feed the actual Server object
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app
