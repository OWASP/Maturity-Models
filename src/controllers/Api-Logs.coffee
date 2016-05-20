express = require 'express'

fs      = require 'fs'

class Api_Logs
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.logs_Folder = __dirname.path_Combine('../../logs')      # todo: use this has the global location of this value

  add_Routes: ()=>
    @.router.get '/logs/path'        , @.path
    @.router.get '/logs/list'        , @.list
    @.router.get '/logs/file/:index' , @.file
    @.router.get '/logs/stream'      , @.stream
    @


  list: (req, res)=>
    res.send @.logs_Folder.files().file_Names()

  file: (req, res)=>
    index = parseInt(req.params?.index)
    if is_Number(index)
      file_Name = @.logs_Folder.files().file_Names()[index]
      if file_Name
        file_Path = @.logs_Folder.path_Combine file_Name        
        if file_Path.file_Exists()
          return res.send  file_Path.file_Contents()

    res.send 'not found'    

  path: (req, res)=>
    res.send @.logs_Folder


  stream: (req,res)=>
    res.send 'not working, needs to be done using web sockets'      

module.exports = Api_Logs    