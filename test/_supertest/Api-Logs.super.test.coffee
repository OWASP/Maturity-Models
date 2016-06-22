Server  = require '../../src/server/Server'
request = require 'supertest'

# not working on travis because there are no logs in the file system
xdescribe '_supertest | Api-Logs', ->
  server  = null                      
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  check_Path = (path, callback)->
    request(app)
      .get version + path
      .expect 200
      .expect 'Content-Type', "text/html; charset=utf-8"
      .expect (res)->
        callback res.text

  check_Path_Json = (path, callback)->
    request(app)
      .get version + path
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res)->
        callback res.body

  it '/logs/path', ()->
    check_Path '/logs/path', (data)->
      data.assert_File_Exists()

  it '/logs/list', ()->
    check_Path_Json '/logs/list', (data)->
      data.assert_Size_Is_Bigger_Than 1
      data.first().assert_Contains 'logs-'

  xit '/logs/file', ()->
    check_Path '/logs/file/0', (data)->
      data.assert_Contains 'GET'