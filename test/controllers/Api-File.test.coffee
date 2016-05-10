Api_File = require '../../src/controllers/Api-File'
Server   = require '../../src/server/Server'

describe 'controllers | Api-Controller', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new Api_File(), ->
      @.constructor.name.assert_Is 'Api_File' 
      @.router.assert_Is_Function()
      @.data.assert_Is_Object()
      
      
  it 'add_Routes', ->
    using new Api_File(app:app), -> 
      @.add_Routes()
      @.router.stack.assert_Size_Is 2

  it 'get', ->
    req = 
      params : 
        filename: 'json-data' 
    res =
      send: (data)->
        data.user.name.assert_Is 'Joe'

    using new Api_File(), ->
      @.get(req, res)

  it 'list', ->

    res =
      send: (data)->
        data.assert_Size_Is(3)
        data.assert_Is [ 'coffee-data.coffee', 'health-care-results.json5', 'json-data.json' ]


    using new Api_File(), ->
      @.data.data_Path.assert_Folder_Exists()
      @.list(null,res)