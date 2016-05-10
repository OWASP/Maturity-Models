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
    server.server_Url().add('/api/v1/routes/list').json_GET (data)->
      using data , ->
        @.assert_Contains ['/ping', '/d3-radar']
        @.assert_Is_Greater_Than 4
      done()
