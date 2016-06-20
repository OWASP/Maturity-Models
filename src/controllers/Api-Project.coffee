Data_Project  = require '../backend/Data-Project'
express       = require 'express'

class Api_Project
  constructor: (options)->
    @.options      = options || {}
    @.router       = express.Router()
    @.data_Project = new Data_Project()
    

  add_Routes: ()=>
    @.router.get '/project/list'         , @.list
    @.router.get '/project/get/:project' , @.get
    @

  list: (req,res)=>
    res.json @.data_Project.ids()

  get: (req,res)=>
    project = req.params?.project
    res.json @.data_Project.project_Files(project).file_Names_Without_Extension()

module.exports = Api_Project