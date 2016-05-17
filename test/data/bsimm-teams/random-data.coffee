start_Server = require '../../../src/main'

describe 'data | bsimm-teams | team-A', ->

  port   = null
  server = null

  beforeEach (done)->
    port = 1000.add 2000.random()
    using start_Server(port : port), ->
      server = @
      done()

  afterEach (done)-> server.stop done

  get_Data_Json = (path, callback)->
    server.server_Url().add(path).json_GET callback

  it 'check team-A.json data is random', (done)->
        
    get_Data_Json '/api/v1/file/get/team-random', (json)-> 
      json.metadata.team.assert_Is 'Team Random'

      matches = { Yes: 0, No : 0, NA: 0, Maybe: 0}

      check_Domain = (domain, size)->
        for activity, value of json.activities[domain]
          matches.keys().assert_Contains value
          matches[value]++

        json.activities[domain].keys().size().assert_Is size

      check_Domain 'Governance'  , 20
      check_Domain 'Intelligence', 15
      check_Domain 'SSDL'        , 15
      check_Domain 'Deployment'  , 19

      for key,value of matches            # check that we have at least one
        value.assert_Is_Bigger_Than 0

      done()

  it 'check team-A.json data is different for two separate requests', (done)->
    get_Data_Json '/api/v1/file/get/team-random', (json_1)->
      get_Data_Json '/api/v1/file/get/team-random', (json_2)->
        json_1.assert_Is_Not json_2
        done()