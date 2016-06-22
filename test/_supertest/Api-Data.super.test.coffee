Server  = require '../../src/server/Server'
request = require 'supertest'

describe '_supertest | Api-Data', ->
  server  = null                       # these are tests that use supertest, which mean they need to be feed the actual Server object
  app     = null
  version = '/api/v1'
  project = null
  team    = null

  before ->
    server  = new Server().setup_Server().add_Controllers()
    app     = server.app
    project = 'bsimm'
    team    = 'team-B'


  check_Path_Json = (path, callback)->
    request(app)
      .get version + path
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        callback res.body

  it '/data/:project/:team/radar', ()->
    check_Path_Json "/data/#{project}/#{team}/radar", (data)->
      data.first().axes.first().assert_Is { axis: "Strategy & Metrics" , xOffset: 1, value: 0}
 
