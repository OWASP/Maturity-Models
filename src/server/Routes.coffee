class Routes
  constructor: (options)->
    @.options = options || {}
    @.app     = @.options.app

  list: ()=>    
    values = []
    if  @.app
      map_Stack = (prefix, stack)->                                         # method to map the express routes
        for item in stack                                                   # walk the stack object
          if item.route                                                     # if there is a route
            values.add(prefix + item.route.path)                            #   add it's path (using provided prefix)
          if item.handle?.stack                                             # if there are sub routes
            baseUrl = item.regexp.str().after('/^\\')                       #   hack to extract the base url
                                       .before_Last('\\/?(?=\\/|$)/i')      #   so that we don't have to change the use function (as seen here http://stackoverflow.com/a/31501504/262379)
                                       .remove('\\')                        #   (cases when there is a / in the url)

            map_Stack  baseUrl, item.handle.stack                           #   recursive call using the baseUrl calculated above
            
      map_Stack '', @.app._router?.stack                                    # start the mapping at the root
    
    values 

module.exports = Routes
