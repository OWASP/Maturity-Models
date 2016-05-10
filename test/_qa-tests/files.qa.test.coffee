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

  make_Request_Json = (target, next) ->
    server.server_Url().add(target).json_GET (data)->
      next data

  make_Request = (target, next) ->
    server.server_Url().add(target).GET (data)->
      next data


  it '/api/v1/files/list', (done)->
    make_Request_Json '/api/v1/file/list', (data)->
      data.assert_Is [ 'coffee-data.coffee', 'health-care-results.json5', 'json-data.json' ]
      done()

  it '/api/v1/file/get/abc', (done)->
    make_Request_Json '/api/v1/file/get/json-data', (data)->
      data.user.name.assert_Is 'Joe'

      make_Request_Json '/api/v1/file/get/health-care-results', (data)->
        data.user.assert_Is 'test'

        make_Request_Json '/api/v1/file/get/coffee-data', (data)->
          data.user.assert_Is 'in coffee'
          done()

  it '/views/files/list', (done)->
    make_Request '/view/file/list', (data)->
      using data , ->
        $ = cheerio.load data 
        $('h2').html().assert_Is 'Available data files' 
        $('a')[2].attribs.assert_Is { href : '/api/v1/file/get/json-data'}
        $.html($('a')[2]).assert_Is '<a href="/api/v1/file/get/json-data">json-data</a>'            
      done()