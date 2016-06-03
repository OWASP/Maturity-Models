Data_Files = require '../backend/Data-Files'
express    = require 'express'

class View_Table
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.data_Files  = new Data_Files()

  add_Routes: ()=>
    @.router.get '/:filename/table'     , @.table
    @.router.get '/:filename/table.json', @.table_Json
    @

  table: (req, res)=>
    filename = req.params?.filename
    if filename
      raw_data   = @.data_Files.get_File_Data filename
      table_Data = @.transform_Data(raw_data)
      title      = raw_data?.metadata?.team

      return res.render 'tables/bsimm-table', table: table_Data, title: title

    return res.send 'not found'

  table_Json: (req,res)=>     # sends the data in a transformation this is easy to show in a table
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
      for key in activities.keys()
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
    

module.exports = View_Table