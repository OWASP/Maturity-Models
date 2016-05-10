Routes  = require '../server/Routes'
express = require 'express'

class Api_Routes
  constructor: (options)->
    @.options = options || {}
    @.router  = express.Router()
    @.app     = @.options.app
    @.routes  = new Routes(app:@.app)

  add_Routes: ()=>
    @.router.get 'list', @.list
    @
    
  list: (req, res)->
    res.send @.routes.list()


module.exports = Api_Routes