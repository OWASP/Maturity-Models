main    = require '../../src/main'
cheerio = require 'cheerio'

describe '_qa-tests | files', ->
  server = null

  beforeEach (done)->
    port = 1000.add 2000.random()
    using main(port : port), ->
      server = @
      done()

  afterEach (done)->
    server.stop ->
      done()

  make_Request = (target, next) ->
    server.server_Url().add(target).json_GET (data)->
      next data

  it '/api/v1/files/list', (done)->
    make_Request '/api/v1/file/list', (data)->
      data.assert_Is [ 'coffee-data.coffee', 'health-care-results.json5', 'json-data.json' ]
      done()

  it '/api/v1/file/get/abc', (done)->
    make_Request '/api/v1/file/get/json-data', (data)->
      data.user.name.assert_Is 'Joe'

      make_Request '/api/v1/file/get/health-care-results', (data)->
        data.user.assert_Is 'test'

        make_Request '/api/v1/file/get/coffee-data', (data)->
          data.user.assert_Is 'in coffee'
          done()