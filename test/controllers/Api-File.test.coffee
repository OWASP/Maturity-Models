Api_File = require '../../src/controllers/Api-File'
#Server   = require '../../src/server/Server'

describe 'controllers | Api-File', ->
  #app      = null
  api_File = null

  before ->
    using new Api_File(), ->
      api_File = @
    #app = new Server().setup_Server().app

  it 'constructor', ->
    using api_File, ->
      @.constructor.name.assert_Is 'Api_File' 
      @.router.assert_Is_Function()
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes', ->
    using api_File, ->
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

  it 'save', ->
    data_Path = api_File.data_Files
                        .data_Path.assert_Folder_Exists()

    file_Name    = "tmp-file"
    file_Path    = "#{data_Path}/#{file_Name}.json"
    initial_Data = { initial: 'data' }
    changed_Data = { other  : 'data' }

    file_Path.file_Write initial_Data.json_Str()

    req =
      params: filename: file_Name
      body  : changed_Data.json_Str()

    res =
      send: (data)->
        file_Path.file_Contents().assert_Is changed_Data.json_Str()
        data.assert_Is { status: 'file saved ok'}
        file_Path.assert_File_Deleted()

    using new Api_File(), ->
      @.save req, res

  it 'save (bad file)', ->
    req =
      params: filename: 'aaaa'
      body  : 'bbb'
    res =
      send: (data)->
        data.assert_Is { error: 'save failed'}

    using new Api_File(), ->
      @.save req, res