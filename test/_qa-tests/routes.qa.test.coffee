main    = require '../../src/main'
cheerio = require 'cheerio'

describe '_qa-tests | routes', ->
  server = null

  beforeEach (done)->
    port = 30000.add 2000.random()
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

  it '/api/v1/ping', (done)->
    server.server_Url().add('/ping').GET (data)->
      data.assert_Is 'pong'
      done()

  it '/api/v1/routes/list', (done)->
    server.server_Url().add('/api/v1/routes/list').json_GET (data)->
      using data , ->
        @.assert_Contains ['/ping', '/d3-radar']
        @.assert_Is_Greater_Than 4
      done()

  it '/view/route/list', (done)->
    server.server_Url().add('/view/routes/list').GET (data)->
      using data , ->
        $ = cheerio.load data
        $('h2').html().assert_Is 'Available routes'
        $('a')[2].attribs.assert_Is { href : '/d3-radar'}
        $.html($('a')[2]).assert_Is '<a href="/d3-radar">/d3-radar</a>'
        links = (a.attribs.href for a in $('a'))                          # get all routes
        links.assert_Size_Is_Bigger_Than 34                                           # the routes should have been substituted here
        links.assert_Contains ['/api/v1/file/get/team-random', '/view/team-random/table']
      done()

  it '/view/route/list', (done)->
    server.server_Url().add('/view/routes/list-raw').GET (data)->
      using data , ->
        $ = cheerio.load data
        $('h2').html().assert_Is 'Available routes'
        $('a')[2].attribs.assert_Is { href : '/d3-radar'}
        $.html($('a')[2]).assert_Is '<a href="/d3-radar">/d3-radar</a>'
        links = (a.attribs.href for a in $('a'))                          # get all routes
        links.assert_Size_Is_Bigger_Than 13                                           # real list of routes
        links.assert_Contains ['/api/v1/file/get/:filename', '/view/:filename/table']
      done()

  it 'redirects', (done)->
    check_Redirect = (source, target, next) ->
      server.server_Url().add(source).GET (data)->
        data.assert_Is "Found. Redirecting to #{target}"
        next()

    check_Redirect '/routes', '/view/routes/list', ->
      done()
 

  it 'check link: back to all routes', (done)->
    server.server_Url().add('/view/file/list').GET (data)->
      $ = cheerio.load data
      link = $('#link-to-routes')
      link.attr().assert_Is { id: 'link-to-routes', href: '/routes', class: 'label round success' }
      link.html().assert_Is 'back to all routes'
      done()