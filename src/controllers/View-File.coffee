Data_Files = require '../backend/Data-Files'
express    = require 'express'

class View_File
  constructor: (options)->
    @.options     = options || {}
    @.router      = express.Router()
    @.app         = @.options.app
    @.data_Files  = new Data_Files()

  add_Routes: ()=>
    @.router.get '/file/list', @.list
    @

  list: (req, res)=>
    res.render 'file-list', files: @.data_Files.files_Names()

module.exports = View_File