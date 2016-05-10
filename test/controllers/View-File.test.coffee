View_File = require '../../src/controllers/View-File'
Server     = require '../../src/server/Server'


describe 'controllers | Api-Controller', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->    
    using new View_File(app: app), ->
      @     .constructor.name.assert_Is 'View_File'
      @.data.constructor.name.assert_Is 'Data'

  it 'add_Routes', ->
    using new View_File(app:app), ->
      @.add_Routes()
      @.router.stack.assert_Size_Is 1

  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'file-list'
        data.files.assert_Size_Is 3

    using new View_File(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list(null, res)
          