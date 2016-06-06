Server  = require '../../src/server/Server'
request = require 'supertest'
cheerio = require 'cheerio'

describe '_supertest | /ui/html', ->
  server  = null
  app     = null
  html    = null
  $       = null

  before ()->
    server = new Server().setup_Server()
                         .add_Controllers()
                         .add_Bower_Support()
                    
    app    = server.app
    request(app)
      .get('/ui/html/')
      .expect 200
      .expect (res)->
        html = res.text
        $    = cheerio.load html

  xit 'Check html doesnt load ok', ->
    html.assert_Is 'Cannot GET /ui/html/\n'

  it 'Check html loaded ok', ->
    #console.log html
    html.size().assert_Bigger_Than 150
    html.assert_Contains 'angular.js'
    $('script').length.assert_Is 2

  it 'Check Server Javascript resources', ->
    request(app)
      .get('/lib/angular/angular.js')
      .expect 200
      .expect (req)->
        req.text.assert_Contains('AngularJS v1.5')
      
  xit 'Angular Components', ->
    $('script').eq(0).attr().src.assert_Is '/lib/angular/angular.js'
    $('html').attr()['ng-app'].assert_Is 'MM_Graph'






