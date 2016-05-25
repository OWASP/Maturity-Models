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
    @.router.get '/file/get-raw/:filename', @.get_Raw
    @

  get: (req, res)=>
    filename = req.params?.filename
    data = @.data.find filename
    if data
      res.setHeader('Content-Type', 'application/json');
      
      if req.query?.pretty is ""
        return res.send data.json_Pretty()
      else
        return res.send data
    else
      res.send { error: 'not found'}

  get_Raw: (req,res)->
    res.send 'nothing to see here'
    #filename = req.params?.filename
    #res.send __dirname.path_Combine( '../data/files')
    #                  .path_Combine filename.file_Contents()


  list: (req, res)=>
    res.send @.data.files().file_Names()

    

module.exports = Api_File