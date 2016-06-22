Api_Data = require '../../src/controllers/Api-Data'

describe 'controllers | Api-Data', ->
  api_Data = null

  beforeEach ->
    api_Data = new Api_Data()

  it 'constructor',->
    using api_Data, ->
      @.constructor.name.assert_Is 'Api_Data'