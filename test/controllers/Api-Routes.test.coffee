Api_File = require '../../src/controllers/Api-File'

describe 'controllers | Api-Controller', ->
  it 'constructor', ->
    using new Api_File(), ->
      @.router.assert_Is_Function()
      