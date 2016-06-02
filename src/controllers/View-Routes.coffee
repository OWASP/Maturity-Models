Data_Files = require '../backend/Data-Files'
Routes     = require '../server/Routes'
express    = require 'express'

class View_Routes
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.routes      = new Routes(app:@.app)
    @.data_Files  = new Data_Files()

  add_Routes: ()=>
    @.router.get '/routes/list'    , @.list
    @.router.get '/routes/list-raw', @.list_Raw
    @ 

  list: (req, res)=>
    keyword = ':filename'
    list    = @.routes.list()
    values  = list                 # create copy we can use without breaking the for loop
    for item in list
      if item.contains keyword
        values = values.remove_If_Contains(item)
        
        for file in @.data_Files.files_Names()
          values.add item.replace keyword, file

    res.render 'routes', routes: values

  list_Raw: (req, res)=>
    res.render 'routes', routes: @.routes.list()

  
  
module.exports = View_Routes