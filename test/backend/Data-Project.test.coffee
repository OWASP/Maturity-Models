Data_Project = require '../../src/backend/Data-Project'

describe 'backend | Data-Project', ->
  data_Project = null

  beforeEach ->
    data_Project = new Data_Project()

  it 'constructor',->
    using data_Project, ->
      @.constructor.name.assert_Is 'Data_Project'
      @.data_Path.assert_Contains 'data'
                 .assert_Folder_Exists()

  it 'list', ->
    using data_Project, ->
      console.log @.list()
