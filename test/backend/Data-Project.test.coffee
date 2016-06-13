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
      assert_Is_Null @.project_Files('aa')
      console.log @.project_Files()
        
  it 'projects', ->
    using data_Project, ->
      @.projects()._keys().assert_Contains('demo', 'appsec')

  it 'projects_Keys', ->
    using data_Project, ->
      @.projects_Keys().assert_Contains('demo', 'appsec')      
