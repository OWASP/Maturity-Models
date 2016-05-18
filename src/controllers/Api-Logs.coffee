express = require 'express'

class Api_Logs
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.logs_Folder = __dirname.path_Combine('../../logs')      # todo: use this has the global location of this value

  add_Routes: ()=>
    @.router.get '/logs/path'               , @.path
    @.router.get '/logs/list'               , @.list
    @.router.get '/logs/file/:log-filename' , @.file
    @


  path: (req, res)=>
    res.send @.logs_Folder

  list: (req, res)=>
    res.send @.logs_Folder.files().file_Names()

  file: (req, res)=>
    log_File_Name = req.params?['log-filename'].to_Safe_String()

module.exports = Api_Logs    