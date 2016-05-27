require 'fluentnode'
Server = require '../../../src/server/Server'
async     = require 'async'

describe 'view - d3-radar', ->

  server = null
  html      = null
  $         = null
  page      = '/d3-radar'

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
    $('script').length.assert_Is 6
    $('script').attr().assert_Is { src: '/lib/jquery/dist/jquery.min.js' } # this only checks the first file
    $('h3'    ).html().assert_Is 'BSIMM Radar Graphs (v0.7.4)'

  it 'check dependencies can be loaded', (done)->
    check_Script =  (target, next)->
      server.get_Html target.attribs.src , ($, html)->
        html.assert_Not_Contains 'Cannot GET'
        next()

    check_Style =  (style, next)->
      server.get_Html style.attribs.href, ($, html)->
        html.assert_Not_Contains 'Cannot GET'
        next()

    async.eachSeries $('script'), check_Script, ->
      async.eachSeries $('link'), check_Style, done
