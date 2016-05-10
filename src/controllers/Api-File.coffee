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
    @.router.get '/files/list', @.list
    #@

  list: ->
    @.data.files()
    

module.exports = Api_File