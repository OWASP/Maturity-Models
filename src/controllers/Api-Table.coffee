Api_Base   = require './Api-Base'
Data_Files = require '../backend/Data-Files'

class Api_Table extends Api_Base
  constructor: (options)->
    @.options     = options || {}
    @.data_Files  = new Data_Files()    
    super(@.options)

  add_Routes: ()=>
    @.add_Route 'get', '/table/:project/:team', @.table
    @

  table: (req,res)=>     # sends the data in a transformation this is easy to show in a table
    project = req.params?.project
    team    = req.params?.team
    if project and team
      data = @.data_Files.get_File_Data project, team
      res.setHeader('Content-Type', 'application/json');
      res.send @.transform_Data(data).json_Pretty()
    else
      res.send {}

  transform_Data: (data)=>
    table =
      headers: ['Governance', 'Intelligence', 'SSDL', 'Deployment']
      rows:    {}


    map_Activities = (activities)->
      return if not activities
      index = 0
      for key in activities._keys()
        table.rows[index] ?= []

        cells = table.rows[index]
        cells.push(key)
        cells.push activities[key]

        index++

    if data and data.activities
      using data.activities, ->
        map_Activities @.Governance
        map_Activities @.Intelligence
        map_Activities @.SSDL
        map_Activities @.Deployment

    return table
    

module.exports = Api_Table