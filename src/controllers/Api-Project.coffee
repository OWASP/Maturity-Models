Data_Project  = require '../backend/Data-Project'
express       = require 'express'

class Api_Project
  constructor: (options)->
    @.options      = options || {}
    @.router       = express.Router()
    @.data_Project = new Data_Project()
    

  add_Routes: ()=>
    @.router.get '/project/list'     , @.list
    @

  list: (req,res)=>
    res.json @.data_Project.projects_Keys()
    
module.exports = Api_Project