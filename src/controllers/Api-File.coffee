Data    = require '../data/Data'
Routes  = require '../server/Routes'
express = require 'express'

class Api_File
  constructor: (options)->
    @.options = options || {}
    @.router  = express.Router()
    @.app     = @.options.app
    @.routes  = new Routes(app:@.app)
    @.data    = new Data()

  add_Routes: ()=>
    @.router.get '/file/list', @.list
    @.router.get '/file/get/:filename', @.get
    @

  get: (req, res)=>
    filename = req.params?.filename
    if filename
      for file in @.data.files_Paths()                          # this can be optimized
        if file.file_Name_Without_Extension() is filename
          return res.send @.data.data file
          
    res.send 'not found'

  list: (req, res)=>
    res.send @.data.files().file_Names()

    

module.exports = Api_File