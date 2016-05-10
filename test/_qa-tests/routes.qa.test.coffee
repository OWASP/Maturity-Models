main = require '../../src/main'

describe '_qa-tests | routes', ->
  server = null

  beforeEach (done)->
    port = 1000.add 2000.random()
    using main(port : port), ->
      server = @
      done()

  afterEach (done)->
    server.stop ->
        done()

  it '/', (done)->
    server.server_Url().add('/').GET (data)->
      data.assert_Is 'Found. Redirecting to d3-radar'
      done()

  it '/ping', (done)->
    server.server_Url().add('/ping').GET (data)->
      data.assert_Is 'pong'
      done()

  it '/routes/list', (done)->
    server.server_Url().add('/routes/list').json_GET (data)->
      data.assert_Is ["/","/ping","/d3-radar","/routes/list"]
      done()
