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
      @.router.stack.assert_Size_Is 1

  it 'list', ->
    using new Api_File(), ->
      @.data.data_Path.assert_Folder_Exists()
      @.list().assert_Size_Is 3