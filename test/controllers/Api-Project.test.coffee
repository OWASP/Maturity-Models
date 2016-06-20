Api_Project = require '../../src/controllers/Api-Project'

describe 'controllers | Api-Project', ->
  api_Project = null

  before ->
    using new Api_Project(), ->
      api_Project = @

  it 'constructor', ->
    using api_Project, ->
      @.constructor.name.assert_Is 'Api_Project'      
      @.data_Project.constructor.name.assert_Is 'Data_Project'
      @.router.assert_Is_Function()

  it 'add_Routes', ()->
    using new Api_Project(), ->
      @.add_Routes()
      @.router.stack.assert_Size_Is 2

  it 'get (null)', ()->
    req =
      params : team : null

    res =
      json: (data)->
        data.assert_Contains ['coffee-data', 'team-A','team-B']

  it 'get (bsimm)', ()->
    req =
      params : project : 'bsimm'

    res =
      json: (data)->
        data.assert_Contains ['coffee-data', 'team-A','team-B']

    using new Api_Project(), ->
      @.get(req, res)

  it 'get (appsec)', ()->
    req =
      params : project : 'appsec'

    res =
      json: (data)->
        data.assert_Contains ['team-D']

    using new Api_Project(), ->
      @.get(req, res)

  it 'list', ()->
    res =
      json: (data)->
        data.assert_Contains ['bsimm', 'appsec'] 

    using new Api_Project(), ->
      @.list(null, res)

