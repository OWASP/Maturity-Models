Server  = require '../../src/server/Server'
request = require 'supertest'
cheerio = require 'cheerio'

describe '_supertest | d3-radar', ->
  server  = null
  app     = null
  $       = null

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app



  xit 'page-components',->
    request(app)
      .get('/routes')
      .expect 200
      .expect (req)->
        console.log req.body