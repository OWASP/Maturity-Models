File_Controller = require '../../src/controllers/File-Controller'

describe 'controllers | File-Controller', ->
  it 'constructor', ->
    using new File_Controller(), ->
      @.router.assert_Is_Function()
      