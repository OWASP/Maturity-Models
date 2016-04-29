express    = require 'express'
load       = require 'express-load'
d3         = require 'd3'
jsdom      = require 'jsdom'
cheerio    = require 'cheerio'

require 'fluentnode'

class D3_Server
  constructor: ->
    @.server = null
    @.port   = 3000

  setup_Server: =>
    
    @.app = express()
    @.app.d3 = d3
    @.app.jsdom = jsdom
    @.app.set 'view engine', 'jade'


    #routes
    @.app.get '/', @.route_Main
    @.app.get '/ping', (req, res) => res.end 'pong'
    @.app.get '/d3-radar', (req, res) => res.render 'd3-radar'

  add_Bower_Support: ()=>
    console.log __dirname
    @.app.use('/lib',  express.static(__dirname + '../bower_components'));

    path = __dirname.path_Combine('../bower_components')
    #file = path.path_Combine('jQuery/dist/jquery.js')
    #console.log file.file_Exists()
    #@.app.use '/lib', serveIndex(path)
    @.app.use '/lib',  express.static path
    #@.app.get('/lib/*', (req,res)->res.send('asd'))

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

  run: (random_Port)=>
    if random_Port
      @.port = 23000 + 3000.random()
    @.setup_Server()
    @.add_Bower_Support()
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


module.exports = D3_Server