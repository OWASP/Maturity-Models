Data_Files = require '../../src/backend/Data-Files'

describe 'controllers | Api-Controller', ->
  data_Files = null

  beforeEach ->
    data_Files = new Data_Files()


  it 'constructor',->
    using data_Files, ->
      @.constructor.name.assert_Is 'Data_Files'
      @.data.constructor.name.assert_Is 'Data'

  it 'get_File', ()->
    filename = 'json-data'
    data =  data_Files.get_File_Data(filename)
    data.user.name.assert_Is 'Joe'
    
  it 'list',->
    using data_Files.list(), ->
      @.assert_Size_Is_Bigger_Than 3
      @.assert_Contains [ 'coffee-data.coffee', 'health-care-results.json5', 'json-data.json' ]
