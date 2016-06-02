Data_Files  = require '../backend/Data-Files'
Routes      = require '../server/Routes'
express     = require 'express'

class Api_File
  constructor: (options)->
    @.options    = options || {}
    @.router     = express.Router()
    @.app        = @.options.app
    @.routes     = new Routes(app:@.app)
    #@.data       = new Data()
    @.data_Files = new Data_Files()

  add_Routes: ()=>
    @.router.get  '/file/list', @.list
    @.router.get  '/file/get/:filename' , @.get
    @.router.post '/file/edit/:filename', @.edit
    @

  edit: (req, res)=>
    console.log 'under construction'

  get: (req, res)=>
    filename = req.params?.filename                       # get filename from path
                                                          # validation is needed here, see https://github.com/DinisCruz/BSIMM-Graphs/issues/18
    data = @.data_Files.get_File_Data filename            # get data
    if data
      res.setHeader('Content-Type', 'application/json');  # todo: need default way to handle this type of responses
      
      if req.query?.pretty is ""                          # todo: this should also be handled in better way (same as above)
        return res.send data.json_Pretty()
      else
        return res.send data
    else
      res.send { error: 'not found'}

  list: (req, res)=>
    res.send @.data_Files.files_Names()

module.exports = Api_File











