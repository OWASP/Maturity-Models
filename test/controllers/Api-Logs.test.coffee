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

  it 'file', ->
    using new Api_Logs(), ->
      req = params : index : 0
      res = send: (data)-> data.assert_Contains 'GET /aaaaa'
      @.file req, res

  it 'file (empty data)', ->
    using new Api_Logs(), ->
      req = {}
      res = send: (data) -> data.assert_Is 'not found'
      @.file req, res

    it 'file (bad data)', ->
    using new Api_Logs(), ->
      req = params : index : 'AAAAA'
      res = send: (data)-> data.assert_Is 'not found'
      @.file req, res
    
  it 'list', ->
    using new Api_Logs(), ->
      res =
        send: (data)->
          data.assert_Size_Is_Bigger_Than 0
      @.list null, res

  it 'path', ->
    using new Api_Logs(), ->
      res =
        send: (data)->
          data.assert_Is __dirname.path_Combine('../../logs')
          data.assert_Folder_Exists()
      @.path null, res
