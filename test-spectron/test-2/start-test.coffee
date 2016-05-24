return 
electron_Prebuild = require 'electron-prebuilt'

Application = require('spectron').Application
assert = require('assert')

describe 'application launch', ->

  @timeout 10000

  beforeEach ()->
    @app = new Application(path: electron_Prebuild)
    @app.start()
    
  afterEach ->
    if @app and @app.isRunning()
      @app.stop()

  it 'shows an initial window', ->
    @app.client.getWindowCount().then (count) ->
      assert.equal count, 1
