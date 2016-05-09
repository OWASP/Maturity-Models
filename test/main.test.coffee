start_Server = require '../src/main'

describe 'main', ->

  port      = null
  d3_Server = null

  beforeEach (done)->
    port = 1000.add 2000.random()
    using start_Server(port : port), ->
      d3_Server = @
      done()

  afterEach (done)->
    d3_Server.stop ->
      d3_Server.server_Url().GET (data)->
        assert_Is_Null data
        done()

  it 'check start_Server setup', (done)->
    start_Server.assert_Is_Function()

    using d3_Server, ->
      @.constructor.name.assert_Is 'D3_Server'
      @.server_Url().assert_Contains port 
      @.server_Url().GET (data)=>
        data.assert_Is 'Found. Redirecting to d3-radar'
        done()

  it 'check d3-graph', (done)->
    using d3_Server, ->
      @.server_Url().add('/d3-radar').GET (html)->
        html.assert_Contains '<!DOCTYPE html><html><head><meta '
        done()

