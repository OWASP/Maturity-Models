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
      @.data_Stats.constructor.name.assert_Is 'Data_Stats'

  it 'add_Routes',->
    using api_Data, ->
      #@.routes_Added.assert_Is [ { method: 'get', path: '/data/:project/:team/radar', action: @.radar }, { method: 'get', path: '/data/:project/:team/score', action: @.score } ]
      @.routes_Added.size().assert_Is 3

  it 'projects_Scores', ->
    req = 
      params:
        project: project
        team   : team
    res =
      json: (data)->
        data[team].level_1.value.assert_Is_Bigger_Than 17.2
    using api_Data, ->
      @.teams_Scores(req,res)
      
  it 'team_Radar', ->
    req =
      params:
        project: project
        team   : team
    res =
      json: (data)->
        data.first().axes.first().axis.assert_Is 'Strategy & Metrics'

    using api_Data, ->
      @.team_Radar(req,res)

  it 'team_Score', ->
    req =
      params:
        project: project
        team   : team
    res =
      json: (data)->
        data.level_1.value.assert_Is_Bigger_Than 17.2

    using api_Data, ->
      @.team_Score(req,res)