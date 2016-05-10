Routes  = require '../server/Routes'
express = require 'express'

class View_Routes
  constructor: (options)->
    @.options = options || {}
    @.router  = express.Router()
    @.app     = @.options.app
    @.routes  = new Routes(app:@.app)

  add_Routes: ()=>
    @.router.get '/routes/list', @.list
    @

  list: (req, res)=>
    res.render 'routes', @.routes.list()

module.exports = View_Routes