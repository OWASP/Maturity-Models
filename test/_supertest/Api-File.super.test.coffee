Server  = require '../../src/server/Server'
request = require 'supertest'

describe '_supertest | Api-File', ->
  server  = null                       # these are tests that use supertest, which mean they need to be feed the actual Server object
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  it '/file/list', ->
    request(app)
      .get version + '/file/list'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        res.body.assert_Size_Is_Bigger_Than 8
                .assert_Contains ['team-A', 'team-B']

  it '/file/get/team-A', ->
    request(app)
      .get version + '/file/get/team-A'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        res.body.metadata.team.assert_Is 'Team A'

  it '/file/save/save-test', ()->
    url_Save = version + '/file/save/save-test'
    data     = { "save" : "test" }
    request(app)
      .post url_Save
      .send data
      .expect 200
      .expect (res)->        
        res.body.assert_Is error: 'file saved ok'