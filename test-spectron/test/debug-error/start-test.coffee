require 'fluentnode'
helpers = require('./global-setup')

appPath = __dirname.path_Combine('../../electron-apps/web-view')

assert = require('assert')

describe 'application launch 4', ->
  #@.timeout 10000
  app   = null
  path  = [ appPath ]

  beforeEach () ->
    #helpers.setupTimeout this
    helpers.startApplication  args: path, (_app)->
      app = _app

  afterEach (done)->
    helpers.stopApplication ->
      done()

  it 'shows an initial window abc', ->
    app.isRunning().assert_Is_True()
    app.client.getWindowCount()
              .then (count) ->
                assert.equal count, 2
