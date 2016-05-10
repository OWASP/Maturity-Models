require 'fluentnode'

express    = require 'express'
load       = require 'express-load'
d3         = require 'd3'
jsdom      = require 'jsdom'
cheerio    = require 'cheerio'
Routes     = require './Routes'
Redirects  = require './Redirects'

require 'fluentnode'

class Server
  constructor: (options)->
    @.app     = null
    @.options = options || {}
    @.server  = null
    @.port    = @.options.port || process.env.PORT || 3000

  setup_Server: =>    
    @.app = express()
    @.app.d3 = d3
    @.app.jsdom = jsdom
    @.app.set 'view engine', 'jade'
    
    #routes
    #@.app.get '/', @.route_Main
    @.app.get '/'          , (req, res) => res.redirect 'd3-radar'
    @.app.get '/ping'      , (req, res) => res.end      'pong'
    @.app.get '/d3-radar'  , (req, res) => res.render   'd3-radar'
    @.app.get '/live-radar', (req, res) => res.render   'live-radar'
    @

  add_Bower_Support: ()=>
    #@.app.use('/lib',  express.static(__dirname + '../bower_components'));
    @.app.use '/lib',  express.static __dirname.path_Combine('../../bower_components')

  add_Controllers: ->
    api_Path  = '/api/v1'
    view_Path = '/view'
    Api_Routes  = require '../controllers/Api-Routes'
    Api_File    = require '../controllers/Api-File'
    View_Routes = require '../controllers/View-Routes'
    View_File   = require '../controllers/View-File'
    View_Table  = require '../controllers/View-Table'

    @.app.use api_Path , new Api_Routes( app:@.app).add_Routes().router 
    @.app.use api_Path , new Api_File(   app:@.app).add_Routes().router
    @.app.use view_Path, new View_Routes(app:@.app).add_Routes().router
    @.app.use view_Path, new View_File(  app:@.app).add_Routes().router
    @.app.use view_Path, new View_Table( app:@.app).add_Routes().router

  add_Redirects: ->
    new Redirects(app:@.app).add_Redirects()

  route_Main: (req, res) ->
    d3 = req.app.d3
    html = '<!doctype html><html></html>'
    document = req.app.jsdom.jsdom(html)

    svg = d3.select(document.body)
              .append('g')

    data = [3, 5, 8, 4, 7,];
    svg.selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
        .attr('cx',  (d, i)->  (i + 1) * 100 - 50  )
        .attr('cy', svg.attr('height') / 2)
        .attr('r',  (d)-> d * 5)
    res.render 'index', svgstuff: svg.node().outerHTML

  start_Server: =>
    @.server = @.app.listen @.port

  server_Url: =>
    "http://localhost:#{@.port}"

  routes: =>    
    new Routes(app:@.app).list()
      
  run: (random_Port)=>
    if random_Port
      @.port = 23000 + 3000.random()
    @.setup_Server()
    @.add_Bower_Support()
    @.add_Controllers()
    @.add_Redirects()
    @.start_Server()

  stop: (callback)=>
    if @.server
      @.server.close =>
        callback() if callback
    else

  get_Html: (virtual_Path, callback)->
    @.server_Url().add(virtual_Path).GET (data)->
      if data 
        $ = cheerio.load(data)
      callback $, data


module.exports = Server