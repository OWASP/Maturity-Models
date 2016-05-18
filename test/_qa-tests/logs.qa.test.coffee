main    = require '../../src/main'
cheerio = require 'cheerio'

describe '_qa-tests | logs', ->
  server = null

  beforeEach (done)->
    port = 30000.add 2000.random()
    using main(port : port), ->
      server = @
      done()

  afterEach (done)->
    server.stop ->
      done()

  it '/aaaaa', (done)->      # make a request to a page that doesn't exist
    server.server_Url().add('/aaaaa').GET (data)->
      data.assert_Is 'Cannot GET /aaaaa\n'
      done()