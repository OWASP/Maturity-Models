Api_File = require '../../src/controllers/Api-File'
Server   = require '../../src/server/Server'

describe 'controllers | Api-File', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new Api_File(), ->
      @.constructor.name.assert_Is 'Api_File' 
      @.router.assert_Is_Function()
      @.data_Files.constructor.name.assert_Is 'Data_Files'
      
      
  it 'add_Routes', ->
    using new Api_File(app:app), ->   
      @.add_Routes()
      @.router.stack.assert_Size_Is 3
      
  it 'get', ->
    req =
      params : 
        filename: 'json-data' 
    res =
      setHeader: (name, value)->
        name.assert_Is 'Content-Type'
        value.assert_Is 'application/json'
      send: (data)->          
        data.user.name.assert_Is 'Joe'

    using new Api_File(), ->
      @.get(req, res)

  it 'get (pretty)', ->
    req =
      params :
        filename: 'json-data'
      query:
        pretty : ''
    res =
      setHeader: (name, value)->
        name.assert_Is 'Content-Type'
        value.assert_Is 'application/json'
      send: (data_pretty)->
        assert_Is_Undefined data_pretty.user
        data = data_pretty.json_Parse()
        data.user.name.assert_Is 'Joe'

    using new Api_File(), ->
      @.get(req, res)

  it 'get (bad data)', ->
    req = params : null
    res =
      send: (data)->
        data.assert_Is {error: 'not found' }
    using new Api_File(), ->
      @.get(req, res)

  it 'list', ->
    res =
      send: (data)->
        data.assert_Size_Is_Bigger_Than 3
        data.assert_Contains [ 'coffee-data', 'health-care-results', 'json-data' ]


    using new Api_File(), ->
      @.data_Files.data_Path.assert_Folder_Exists()
      @.list(null,res)