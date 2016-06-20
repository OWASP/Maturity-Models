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

  it 'project_Files', ->
    using data_Project, ->
      @.project_Files().file_Names().assert_Is [ 'coffee-data.coffee', 'json-data.json', 'save-test.json', 'team-A.json',
                                                 'team-B.json', 'team-C.json', 'team-random.coffee' ]
      @.project_Files('aa').assert_Is []

  it 'projects', ->
    using data_Project, ->
      @.projects()._keys().assert_Contains('demo', 'appsec')

  it 'projects_Keys', ->
    using data_Project, ->
      @.projects_Keys().assert_Contains('demo', 'appsec')      
      
   
      