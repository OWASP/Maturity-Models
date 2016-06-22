Api_Data = require '../../src/controllers/Api-Data'

describe 'controllers | Api-Data', ->
  api_Data = null
  project  = null
  team     = null

  beforeEach ->
    using new Api_Data(), ->
      api_Data = @
      project  = 'bsimm'
      team     = 'team-A'
      @.add_Routes()

  it 'constructor',->
    using api_Data, ->
      @           .constructor.name.assert_Is 'Api_Data'
      @.data_Radar.constructor.name.assert_Is 'Data_Radar'
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes',->
    using api_Data, ->
      @.routes_Added.assert_Is [ { method: 'get', path: '/data/:project/:team/radar', action: @.radar } ]

  it 'radar', ->
    req =
      params:
        project: project
        team   : team
    res =
      json: (data)->
        data.first().axes.first().axis.assert_Is 'Strategy & Metrics'

    using api_Data, ->
      @.radar(req,res)