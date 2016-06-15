Server  = require '../../src/server/Server'
request = require 'supertest'

describe '_supertest | Api-Project', ->
  server  = null                       # these are tests that use supertest, which mean they need to be feed the actual Server object
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  it '/project/list', ->
    request(app)
      .get version + '/project/list'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        res.body.assert_Contains ['demo', 'appsec']