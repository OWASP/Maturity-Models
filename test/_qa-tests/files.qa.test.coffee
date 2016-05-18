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
      data.assert_Contains [ 'coffee-data.coffee', 'health-care-results.json5', 'json-data.json' ]
      done()

  it '/api/v1/file/get/AAAA', (done)->
    make_Request_Json '/api/v1/file/get/AAA', (data)->
      data.error.assert_Is 'not found'
      done()       
      
  it '/api/v1/file/get/json-data', (done)->
    make_Request_Json '/api/v1/file/get/json-data', (data)->
      data.user.name.assert_Is 'Joe'

      make_Request_Json '/api/v1/file/get/health-care-results', (data)->
        data.user.assert_Is 'test'

        make_Request_Json '/api/v1/file/get/coffee-data', (data)->
          data.user.assert_Is 'in coffee'
          done()
           
  it '/api/v1/file/get/json-data?pretty', (done)->
    make_Request '/api/v1/file/get/json-data', (data_json)->
      make_Request '/api/v1/file/get/json-data?pretty', (data_pretty)->
        data_json.str().assert_Is_Not data_pretty
        data_json.json_Parse().assert_Is data_pretty.json_Parse()
        done()

  it '/views/files/list', (done)->
    make_Request '/view/file/list', (data)->
      using data , ->
        $ = cheerio.load data
        $('h2').html().assert_Is 'Available data files' 
        $('a')[2].attribs.assert_Is { href : '/api/v1/file/get/json-data?pretty'}
        $.html($('a')[2]).assert_Is '<a href="/api/v1/file/get/json-data?pretty">json-data</a>'
      done()