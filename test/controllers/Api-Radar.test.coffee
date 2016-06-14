Api_Radar = require '../../src/controllers/Api-Radar'
#Server   = require '../../src/server/Server'

describe 'controllers | Api-Radar', ->
#app      = null
  api_Radar = null

  before ->
    using new Api_Radar(), ->
      api_Radar = @

  it 'constructor', ->
    using api_Radar, ->
      @.constructor.name.assert_Is 'Api_Radar'
      #@.router.assert_Is_Function()
      #@.data_Files.constructor.name.assert_Is 'Data_Files'