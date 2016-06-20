Routes       = require '../server/Routes'
Data_Files   = require '../backend/Data-Files'
Data_Project = require '../backend/Data-Project'
express      = require 'express'

class Api_Routes
  constructor: (options)->
    @.options      = options || {}
    @.router       = express.Router()
    @.app          = @.options.app
    @.routes       = new Routes(app:@.app)
    @.data_Files   = new Data_Files()
    @.data_Project = new Data_Project()

  add_Routes: ()=>
    @.router.get '/routes/list'    , @.list
    @.router.get '/routes/list-raw', @.list_Raw
    @
    
  list: (req, res)=>
    keyword = ':team'
    default_Project = 'bsimm'      # todo: add logic to also map :project
    list    = @.routes.list()
    values  = list                 # create copy we can use without breaking the for loop
    for item,index in list
      #console.log item
      # if item.contains[':project']
      #  list[index] = item.replace ':project', project

      if item.contains keyword

        values = values.remove_If_Contains(item)

        for file in @.data_Files.files_Names(default_Project)
          values.add(item.replace(keyword, file)
                         .replace ':project', default_Project)

    res.send values

  list_Raw: (req, res)=>
    res.send @.routes.list()


module.exports = Api_Routes