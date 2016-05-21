start_Server = require '../../../src/main'

describe 'data | bsimm-teams | team-A', ->

  port      = null
  server = null

  beforeEach (done)->
    port = 1000.add 2000.random()
    using start_Server(port : port), ->
      server = @
      done()

  afterEach (done)->
    server.stop ->
      server.server_Url().GET (data)->
        assert_Is_Null data
        done()

  get_Data_Json = (path, callback)->
    server.server_Url().add(path).json_GET callback

  it 'check team-A.json data', (done)->
    get_Data_Json '/api/v1/file/get/team-A', (json)-> 
      json.metadata.team.assert_Is 'Team A'
      json.activities.Governance['SM.1.1'].assert_Is 'Yes'
      json.activities.keys().assert_Size_Is 4
      json.activities.Governance.keys().assert_Size_Is 20
      done()
