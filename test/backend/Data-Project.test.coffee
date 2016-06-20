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
      project = 'bsimm'
      @.project_Files(project).file_Names().assert_Is [ 'empty.json','coffee-data.coffee', 'json-data.json', 'save-test.json','team-A.json',
                                                 'team-B.json', 'team-C.json', 'team-random.coffee' ]
      @.project_Files('aa').assert_Is []

  it 'projects', ->
    using data_Project, ->      
      using @.projects(), ->
        @._keys().assert_Contains('bsimm', 'appsec')
        using @['bsimm'],->
          @.path_Root.file_Name().assert_Is 'BSIMM-Graphs-Data'
          @.path_Teams.file_Name().assert_Is 'teams'
          @.path_Teams.assert_Is @.path_Root.path_Combine 'teams'
          @.path_Teams.assert_Folder_Exists()
          @.data.key.assert_Is 'bsimm'
      

  it 'ids', ->
    using data_Project, ->
      @.ids().assert_Contains('bsimm', 'appsec')
      
   
      