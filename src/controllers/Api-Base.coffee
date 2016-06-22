express    = require 'express'

class Api_Base
  constructor: ()->    
    @.router       = express.Router()
    @.routes_Added = []

  add_Route: (method, path, action)=>
    if @.router[method] and path and action
      @.routes_Added.add { method: method , path: path, action:action}
      @.router[method] path, action

  routes_Stack: ->
    @.router.stack
    
module.exports = Api_Base