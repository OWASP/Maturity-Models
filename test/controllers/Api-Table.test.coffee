Api_Table = require '../../src/controllers/Api-Table'
Server     = require '../../src/server/Server'


describe 'controllers | Api-Table', ->
  app       = null
  req       = null
  view_File = null

  beforeEach ->
    app = new Server().setup_Server().app
    req =
      params :
        project:  'demo'
        team   : 'team-A'

    using new Api_Table(app:app), ->
      view_File = @

  it 'constructor', ->
    using new Api_Table(app: app), ->
      @           .constructor.name.assert_Is 'Api_Table'
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes', ->
    using new Api_Table(app:app), ->
      @.add_Routes()
      @.router.stack.assert_Size_Is 1

  it 'table (bad file)', ->
    res = send: (data)-> data.assert_Is {}
    req = params: null
    view_File.table(req, res)

  it 'table_Json', ->
    res =
      setHeader: (key,value)->
        key  .assert_Is 'Content-Type'
        value.assert_Is 'application/json' 
      send: (data)->
        data = data.json_Parse()            # required because the data is json_Pretty
        data.headers.assert_Is ['Governance', 'Intelligence', 'SSDL', 'Deployment']
        data.rows._keys().size().assert_Is 20
        data.rows[0].size().assert_Is 8
        data.rows[0].assert_Is [ 'SM.1.1', 'Yes', 'AM1.2', 'Maybe',
                                 'AA.1.1','Maybe','PT.1.1','Maybe' ]
    view_File.table(req, res)
