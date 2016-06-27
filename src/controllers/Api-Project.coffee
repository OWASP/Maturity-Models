Api_Base     = require './Api-Base'
Data_Project = require '../backend/Data-Project'

class Api_Project extends Api_Base
  constructor: ()->
    @.data_Project = new Data_Project()
    super()

  add_Routes: ()=>
    @.add_Route 'get', '/project/get/:project'   , @.get
    @.add_Route 'get', '/project/list'           , @.list
    @.add_Route 'get', '/project/schema/:project', @.schema
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