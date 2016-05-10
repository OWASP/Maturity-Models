Data    = require '../data/Data'
express = require 'express'

class View_Table
  constructor: (options)->
    @.options = options || {}
    @.router  = express.Router()
    @.app     = @.options.app
    @.data    = new Data()

  add_Routes: ()=>
    @.router.get '/:filename/table'     , @.table
    @.router.get '/:filename/table.json', @.table_Json
    @

  table: (req, res)=>
    filename = req.params?.filename
    if filename
      data = @.data.find filename
      return res.render 'tables/bsimm-table', table: data

    return res.send 'not found'

  table_Json: (req,res)=>     # sends the data in a transformation this is easy to show in a table
    filename = req.params?.filename
    if filename
      data = @.data.find filename
      res.setHeader('Content-Type', 'application/json');

      return res.send @.transform_Data data.json_Pretty()

    return res.send {}

  transform_Data: (data)=>
    table =
      headers: ['Governance', 'Intelligence', 'SSD', 'Deployment']
      rows:    {}



    map_Activities = (activities)->
      index = 0
      for key in activities.keys().take(2)
        table.rows[index] ?= []

        cells = table.rows[index]
        cells.push(key)
        cells.push activities[key]

        index++


    map_Activities data.activities.Governance
    map_Activities data.activities.Intelligence
    map_Activities data.activities.SSDL
    map_Activities data.activities.Deployment

    return table
    

module.exports = View_Table