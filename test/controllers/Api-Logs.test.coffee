Api_Logs = require '../../src/controllers/Api-Logs'
Server   = require '../../src/server/Server'

describe 'controllers | Api-Controller', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new Api_Logs(), ->
      @.constructor.name.assert_Is 'Api_Logs'
      @.router.assert_Is_Function()

  it 'path', ->
    using new Api_Logs(), ->
      res =
        send: (data)->
          data.assert_Is __dirname.path_Combine('../../logs')
          data.assert_Folder_Exists()
          #data.folder_Delete_Recursive();
      @.path null, res

  it 'list', ->
    using new Api_Logs(), ->
      res =
        send: (data)->
          data.assert_Size_Is_Bigger_Than 0
      @.list null, res      
