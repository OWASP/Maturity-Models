module.exports = {}
return
Application = require('spectron').Application
path        = require('path')

assert      = require('assert')
#chai   = require('chai')

class Global_Setup
  constructor: ->
    @.app = null

  getElectronPath: ->
    console.log __dirname
    path.join(__dirname, '../../../', 'node_modules', '.bin', 'electron')

  #setupTimeout: (test) ->
    #if process.env.CI
    #  test.timeout 30000
    #else
    #  test.timeout 10000

  startApplication: (options, callback) ->
    options.path = @.getElectronPath()

    #if process.env.CI
    #  options.startTimeout = 30000

    @.app = new Application(options)

    @.app.start()
         .then =>
            assert.equal @.app.isRunning(), true
            callback(@.app)
            #chaiAsPromised.transferPromiseness = @.app.transferPromiseness
            #return @.app

  stopApplication: (callback) =>
    if !@.app or !@.app.isRunning()
      return
    @.app.stop().then =>
      callback()
      #assert.equal @.app.isRunning(), false

module.exports = new Global_Setup()