require 'fluentnode'

spectron = require 'spectron'

class Spectron_API
  
  constructor: ->
    @.Application = spectron.Application
    @.app         = null

  default_App_Path: ->
    __dirname.path_Combine('../electron-apps/web-view')

  setup: =>
    options = path : @.default_App_Path
    @.app = new @.Application options
    @

  start: =>
    @.app.start()

  stop: =>
    @.app.stop()

module.exports =   Spectron_API