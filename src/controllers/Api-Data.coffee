Api_Base     = require './Api-Base'
Data_Radar   = require '../backend/Data-Radar'
Data_Files   = require '../backend/Data-Files'

class Api_Data extends Api_Base
  constructor: ->
    @.data_Radar = new Data_Radar()
    @.data_Files = new Data_Files()
    super()
    
  add_Routes: ->
    @.add_Route 'get' , '/data/:project/:team/radar' , @.radar
    @
    
  radar: (req, res)=>
    project = req.params?.project
    team    = req.params?.team
    
    if project and team
      file_Data  = @.data_Files.get_File_Data project, team
      radar_Data = @.data_Radar.get_Radar_Data file_Data
      res.json radar_Data

    
module.exports = Api_Data