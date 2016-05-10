class Routes
  constructor: (options)->
    @.options = options || {}
    @.app     = @.options.app

  list: ()=>
    values = []
    if  @.app
      for item in @.app._router.stack
        if item.route
          values.add(item.route.path)
    values

module.exports = Routes
