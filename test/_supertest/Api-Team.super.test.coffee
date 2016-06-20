Server  = require '../../src/server/Server'
request = require 'supertest'

describe '_supertest | Api-Team', ->
  server  = null                       # these are tests that use supertest, which mean they need to be feed the actual Server object
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  it '/team/list', ->
    request(app)
      .get version + '/team/bsimm/list'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->        
        res.body.assert_Size_Is_Bigger_Than 5
                .assert_Contains ['team-A', 'team-B']

  it '/team/demo/get/team-A', ->
    request(app)
      .get version + '/team/bsimm/get/team-A'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        res.body.metadata.team.assert_Is 'Team A'

  # Issue 27 - Find better solution for chained super test requests
  it '/team/demo/save/save-test 1', ()->
    url_Save = version + '/team/bsimm/save/save-test'
    data     = { "save" : "test" }
    request(app)
      .post url_Save
      .send data
      .expect 200
      .expect (res)->        
        res.body.assert_Is status: 'file saved ok'
        
  it '/team/demo/save/save-test 2', ()->
    url_Save = version + '/team/bsimm/save/save-test'
    data     = { "will-be" : "changed by tests" }
    request(app)
      .post url_Save
      .send data
      .expect 200
      .expect (res)->
        res.body.assert_Is status: 'file saved ok'