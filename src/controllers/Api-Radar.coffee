class Api_Radar
  constructor: (options)->
    @.options     = options || {}
    #@.router      = express.Router()
    #@.app         = @.options.app


  add_Routes: ()=>
    @.router.get '/radar/abc'          , @.path

    
module.exports = Api_Radar