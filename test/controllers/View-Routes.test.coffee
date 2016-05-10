View_Routes = require '../../src/controllers/View-Routes'
Server     = require '../../src/server/Server'


describe 'controllers | Api-Controller', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new View_Routes(null), ->
      @.options.assert_Is {}
    using new View_Routes(app: app), ->
      @       .constructor.name.assert_Is 'View_Routes'

  it 'add_Routes', ->
    using new View_Routes(app:app), ->      
      @.add_Routes()
      @.router.stack.assert_Size_Is 1

  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.assert_Is routes: [ '/', '/ping', '/d3-radar' , '/live-radar', '/routes/list']

    using new View_Routes(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list(null, res)
          