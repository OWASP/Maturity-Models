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

  it '/v1/api/logs/file/0', (done)->      # make a request to a page that doesn't exist
    server.server_Url().add('/api/v1/logs/file/0').GET (logs_Data)->
      console.log logs_Data 
      logs_Data.assert_Contains 'GET /aaaa'
      done()

  it '/v1/api/logs/file/aaabbb', (done)->      # make a request to a page that doesn't exist
    server.server_Url().add('/api/v1/logs/file/aaabbb').GET (logs_Data)->
      console.log logs_Data
      logs_Data.assert_Is 'not found'
      done()

  it '/v1/api/logs/path', (done)->      # make a request to a page that doesn't exist
    server.server_Url().add('/api/v1/logs/path').GET (logs_Path)->
      logs_Path.assert_Is_Not 'Cannot GET /api/v1/logs/path\n'
               .assert_Folder_Exists()
      done()

  it '/api/v1/logs/list', (done)->
    server.server_Url().add('/api/v1/logs/list').json_GET (logs_File_Names)-> 
      logs_File_Names.assert_Size_Is_Greater_Than 0
      server.server_Url().add('/api/v1/logs/path').GET (logs_Path)->
        log_File = logs_Path.path_Combine logs_File_Names.first()
        log_File.assert_File_Exists()
        log_File.file_Contents().assert_Contains 'GET '
        done()