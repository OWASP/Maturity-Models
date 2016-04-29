express = require 'express'
load    = require 'express-load'
d3      = require 'd3'
jsdom   = require 'jsdom'
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
    @.app.get '/', @.route_Main
    @.app.get '/ping', (req, res) => res.end 'pong'

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

module.exports = D3_Server