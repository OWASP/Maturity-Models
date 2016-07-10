Server  = require '../../../src/server/Server'
request = require 'supertest'

describe '_regression | api', ->
  server  = null
  app     = null
  version = '/api/v1'

  before ->
    server = new Server().setup_Server().add_Controllers()
    app    = server.app

  #https://github.com/DinisCruz/Maturity-Models/issues/63
  it 'Issue 63 - Angular "Duplicates in a repeater are not allowed" error', ->
    request(app)
      .get version + '/team/bsimm/list'
      .expect (res)->
        list        = res.body
        list.duplicates().assert_Is []              # check there are no duplicates
        list.assert_Not_Contains ['maturity-model'] # check this file is not there
