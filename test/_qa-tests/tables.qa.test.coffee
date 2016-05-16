main    = require '../../src/main'
cheerio = require 'cheerio'

describe '_qa-tests | tables', ->
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
    server.server_Url().add(target).GET (data)->
      next data

  it '/view/aaaaa/table', (done)->
    make_Request '/view/aaaaa/table', (data)->
      using data , ->
        $ = cheerio.load data
        $('h2').html().assert_Is 'BSIMM Table for undefined'  # BUG
        done()
        
  it '/view/team-A/table', (done)->
    make_Request '/view/team-A/table', (data)->   
      using data , ->        
        $ = cheerio.load data
        $('h2').html().assert_Is 'BSIMM Table for Team A'
        $('th').length.assert_Is 4
        $($('th')[0]).html().assert_Is 'Governance'
        $($('th')[1]).html().assert_Is 'Intelligence'
        $($('th')[2]).html().assert_Is 'SSDL'
        $($('th')[3]).html().assert_Is 'Deployment'

        $('tr').length.assert_Is 22
      done()