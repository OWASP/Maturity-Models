Application = require('spectron').Application
assert = require('assert')
chai = require('chai')
chaiAsPromised = require('chai-as-promised')
path = require('path')
global.before ->
  chai.should()
  chai.use chaiAsPromised
  return

exports.getElectronPath = ->
  electronPath = path.join(__dirname, '../../../', 'node_modules', '.bin', 'electron')
  electronPath

exports.setupTimeout = (test) ->
  if process.env.CI
    test.timeout 30000
  else
    test.timeout 10000
  return

exports.startApplication = (options) ->
  options.path = exports.getElectronPath()
  if process.env.CI
    options.startTimeout = 30000
  app = new Application(options)
  app.start().then ->
    assert.equal app.isRunning(), true
    chaiAsPromised.transferPromiseness = app.transferPromiseness
    app

exports.stopApplication = (app) ->
  if !app or !app.isRunning()
    return
  app.stop().then ->
    assert.equal app.isRunning(), false
    return