Data_Project  = require '../backend/Data-Project'
express       = require 'express'

class Api_Project
  constructor: (options)->
    @.options      = options || {}
    @.router       = express.Router()
    @.data_Project = new Data_Project()
    

  add_Routes: ()=>
    @.router.get '/project/get/:project'   , @.get
    @.router.get '/project/list'           , @.list
    @.router.get '/project/schema/:project', @.schema
    @

  get: (req,res)=>
    project = req.params?.project
    res.json @.data_Project.project_Files(project).file_Names_Without_Extension()

  list: (req,res)=>
    res.json @.data_Project.ids()


  schema: (req,res)=>
    project = req.params?.project
    res.json @.data_Project.project_Schema(project)

module.exports = Api_Project