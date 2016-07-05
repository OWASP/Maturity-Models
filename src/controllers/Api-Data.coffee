Api_Base     = require './Api-Base'
Data_Radar   = require '../backend/Data-Radar'
Data_Files   = require '../backend/Data-Files'
Data_Stats   = require '../backend/Data-Stats'

class Api_Data extends Api_Base
  constructor: ->
    @.data_Radar = new Data_Radar()
    @.data_Files = new Data_Files()
    @.data_Stats = new Data_Stats()

    super()

  add_Routes: ->
    @.add_Route 'get' , '/project/scores/:project'    , @.teams_Scores
    @.add_Route 'get' , '/data/:project/:team/radar'  , @.team_Radar
    @.add_Route 'get' , '/data/:project/:team/score'  , @.team_Score
    @

  teams_Scores : (req, res)=>
    project = req.params?.project
    res.json @.data_Stats.teams_Scores project

  team_Radar: (req, res)=>
    project = req.params?.project
    team    = req.params?.team

    if project and team
      file_Data  = @.data_Files.get_File_Data project, team
      radar_Data = @.data_Radar.get_Radar_Data file_Data
      res.json radar_Data

  team_Score: (req, res)=>
    project = req.params?.project
    team    = req.params?.team
    res.json @.data_Stats.team_Score project, team



module.exports = Api_Data