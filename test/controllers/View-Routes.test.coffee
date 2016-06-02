View_Routes = require '../../src/controllers/View-Routes'
Server     = require '../../src/server/Server'


describe 'controllers | View-Routes', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new View_Routes(null), ->
      @.options.assert_Is {}
    using new View_Routes(app: app), ->
      @           .constructor.name.assert_Is 'View_Routes'
      @.router    .constructor.name.assert_Is 'Function'
      @.app       .constructor.name.assert_Is 'EventEmitter'
      @.routes    .constructor.name.assert_Is 'Routes'
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes', ->
    using new View_Routes(app:app), ->      
      @.add_Routes()
      @.router.stack.assert_Size_Is 2

  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.routes.assert_Size_Is 22
                   .assert_Contains '/api/v1/file/get/team-random'
                   .assert_Contains '/view/team-random/table'

    using new View_Routes(app:app), ->
      @.app.get '/api/v1/file/get/:filename', ()->
      @.app.get '/view/:filename/table', ()->
      @.list(null, res)


  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.assert_Is routes: [ '/', '/ping', '/d3-radar' , '/live-radar', '/routes/list', '/routes/list-raw']

    using new View_Routes(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list(null, res)

  it 'list-raw', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.assert_Is routes: [ '/', '/ping', '/d3-radar' , '/live-radar', '/routes/list', '/routes/list-raw']

    using new View_Routes(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list_Raw(null, res)
          