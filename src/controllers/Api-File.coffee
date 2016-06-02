Data_Files  = require '../backend/Data-Files'
Data        = require '../data/Data'
Routes      = require '../server/Routes'
express     = require 'express'

class Api_File
  constructor: (options)->
    @.options    = options || {}
    @.router     = express.Router()
    @.app        = @.options.app
    @.routes     = new Routes(app:@.app)
    @.data       = new Data()
    @.data_files = new Data_Files()

  add_Routes: ()=>
    @.router.get  '/file/list', @.list
    @.router.get  '/file/get/:filename' , @.get
    @.router.post '/file/edit/:filename', @.edit
    @

  edit: (req, res)=>
    console.log 'under construction'
    
  get: (req, res)=>
    filename = req.params?.filename                 # get filename from path
                                                    # validation is needed here, see issue ...
    data = @.data_files.get_File_Data filename      #
    if data
      res.setHeader('Content-Type', 'application/json');
      
      if req.query?.pretty is ""
        return res.send data.json_Pretty()
      else
        return res.send data
    else
      res.send { error: 'not found'}

  list: (req, res)=>
    res.send @.data_files.list()

    

module.exports = Api_File