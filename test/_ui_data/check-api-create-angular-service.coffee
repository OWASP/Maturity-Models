# these are a special types of tests that will
#  a) confirm that the consumed (by the UI) APIs are still behaving as expected
#  b) create an angularJS data service

Server  = require '../../src/server/Server'
request = require 'supertest'


describe '_ui_data | create api , create angular service' ,->
  server       = null
  app          = null
  version      = '/api/v1'
  path_UI_Code = './ui/src/services'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  it 'check access to ui code', ->
    path_UI_Code.files().file_Names().assert_Contains [ 'MM_Graph_API.coffee', 'Render-View.coffee','Test-Data.coffee' ]
    path_UI_Code.assert_Folder_Exists()


  it 'bssim schema', ->
    project = 'bsimm'
    path = "#{version}/project/schema/#{project}"
    request(app).get(path).expect(200)
      .expect (res)->
        schema = res.body
        console.log schema.domains._keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]