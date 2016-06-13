Data_Files = require '../backend/Data-Files'
express    = require 'express'

class Api_Table
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.data_Files  = new Data_Files()

  add_Routes: ()=>
    @.router.get '/table/:filename'     , @.table
    @

  table: (req,res)=>     # sends the data in a transformation this is easy to show in a table
    filename = req.params?.filename
    if filename
      data = @.data_Files.get_File_Data filename
      res.setHeader('Content-Type', 'application/json');

      return res.send @.transform_Data(data).json_Pretty()

    return res.send {} 

  transform_Data: (data)=>
    table =
      headers: ['Governance', 'Intelligence', 'SSDL', 'Deployment']
      rows:    {}


    map_Activities = (activities)->
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