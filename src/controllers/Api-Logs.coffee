express = require 'express'

class Api_Logs
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.logs_Folder = __dirname.path_Combine('../../logs')      # todo: use this has the global location of this value

  add_Routes: ()=>
    @.router.get '/logs/path', @.path
    @.router.get '/logs/list', @.list
    @


  path: (req, res)=>
    res.send @.logs_Folder

  list: (req, res)=>
    res.send @.logs_Folder.files().file_Names()

module.exports = Api_Logs    