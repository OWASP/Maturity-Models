require 'fluentnode'
Server = require '../../../src/server/Server'
async     = require 'async'

describe 'view - d3-radar', ->

  server = null
  html      = null
  $         = null
  page      = '/live-radar'

  beforeEach (done)->
    using new Server(), ->
      server = @
      @.run(true)
      @.get_Html page, (_$, _html)->
        $ = _$
        html = _html
        done()

  afterEach ->
    server.stop

  it 'html components', ->
    $.assert_Is_Function()
    $('script').length.assert_Is 5
    $('script').attr().assert_Is { src: '/lib/jquery/dist/jquery.min.js' } # this only checks the first file
    $('h3'    ).html().assert_Is 'BSIMM Radar Graphs (ajax data)'
