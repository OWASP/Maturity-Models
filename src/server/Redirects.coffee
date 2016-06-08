class Redirects
  constructor: (options)->
    @.options = options || {}
    @.app     = @.options.app

  add_Redirects: ->
    @.app.get '/'      , (req,res)-> res.redirect '/view'
    #@.app.get '/routes', (req,res)-> res.redirect '/view/routes/list'

module.exports =  Redirects