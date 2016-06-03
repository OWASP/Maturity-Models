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
    #url_Get  = version + '/file/get/team-C'
    url_Save = version + '/file/save/save-test'
    server = request(app)

    console.log url_Save

    data = { save : 'test' }
    server.post url_Save
      .send data
      .set 'Accept', /application\/json/
      .expect 200
      .expect (res)->
        res.body.assert_Is error: 'file saved ok AAAAA'

    return

#    server
#      .get(url_Get)
#      .expect (res)->
#        asd.asd()
#        data = res.data
#        console.log data
#        done()



#    return
#    get_Data = (next)->
#      server.get(url_Get)
#        .expect (res)->

#          next(res.body)

#    save_Data = (data, next)->
#      data.team = 'BBBBB'
#      console.log  data
#      server.post url_Save
#          .send data
#          .set 'Accept', /application\/json/
#          .expect 500
#          .expect (res)->
#            res.body.assert_Is error: 'file saved okl'
#            next()
#
#    check_Data = (next)->
#
#    get_Data (data)->
#      save_Data data, ()->
#        console.log 'here'
