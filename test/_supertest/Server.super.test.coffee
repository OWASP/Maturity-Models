Server  = require '../../src/server/Server'
request = require 'supertest'

describe '_supertest | Server', ->
  server  = null
  app     = null

  before ->
    server = new Server().setup_Server().add_Controllers().add_Redirects()
    app    = server.app

  it '/aaaa (bad file)', ->                       #
    request(app)
      .get('/aaaa')
      .expect 404

  it '/ (redirect)', ->
    request(app)
      .get('/')
      .expect 302

  it '/ (redirect)', ->
    request(app)
      .get('/')
      .expect 302
      .expect (res)->
        res.headers.location.assert_Is '/view'
