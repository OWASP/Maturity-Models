Data    = require '../data/Data'
express = require 'express'

class View_File
  constructor: (options)->
    @.options = options || {}
    @.router  = express.Router()
    @.app     = @.options.app
    @.data    = new Data()

  add_Routes: ()=>
    @.router.get '/file/list', @.list
    @

  list: (req, res)=>
    res.render 'file-list', files: @.data.files_Names()

module.exports = View_File