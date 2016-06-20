Routes     = require '../server/Routes'
Data_Files = require '../backend/Data-Files'
express    = require 'express'

class Api_Routes
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
    keyword = ':team'
    list    = @.routes.list()
    values  = list                 # create copy we can use without breaking the for loop
    for item in list
      if item.contains keyword
        values = values.remove_If_Contains(item)

        for file in @.data_Files.files_Names()
          values.add item.replace keyword, file
          
    res.send values

  list_Raw: (req, res)=>
    res.send @.routes.list()


module.exports = Api_Routes