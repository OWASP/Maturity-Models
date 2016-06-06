Server  = require '../../src/server/Server'
request = require 'supertest'
cheerio = require 'cheerio'

describe '_supertest | /angular', ->
  server  = null
  app     = null
  html    = null
  $       = null

  before ()->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app
    request(app)
      .get('/angular')
      .expect 200
      .expect (res)->
        html = res.text
        $    = cheerio.load html

  it 'Check html loaded ok', ->
    html.size().assert_Bigger_Than 300
    html.assert_Contains 'angular.js'
    $('script').length.assert_Is 2

  it 'Angular Components', ->
    $('html').attr()['ng-app'].assert_Is 'MM_Graph'






