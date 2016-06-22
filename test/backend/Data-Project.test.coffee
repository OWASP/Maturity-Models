Data_Project = require '../../src/backend/Data-Project'

describe 'backend | Data-Project', ->
  data_Project = null
  project      = null
  beforeEach ->
    project = 'bsimm'
    data_Project = new Data_Project()

  it 'constructor',->
    using data_Project, ->
      @.constructor.name.assert_Is 'Data_Project'
      @.data_Path.assert_Contains 'data'
                 .assert_Folder_Exists()

  it 'project_Files', ->
    using data_Project, ->      
      @.project_Files(project).file_Names().assert_Contains [ 'empty.json','coffee-data.coffee', 'json-data.json', 'save-test.json','team-A.json',
                                                              'team-B.json', 'team-C.json', 'team-random.coffee' ]
      @.project_Files('aa').assert_Is []
      
  it 'project_Schema', ->
    using data_Project, ->
      schema = @.project_Schema project
      schema['SM.1.1'].assert_Is { level: '1', activity: 'Is there a formal SDL (Software Development Lifecycle) used?' }

      @.project_Schema(null ).assert_Is {}
      @.project_Schema('aaa').assert_Is {}
      @.project_Schema({}   ).assert_Is {}

  it 'projects', ->
    using data_Project, ->      
      using @.projects(), ->
        @._keys().assert_Contains(project, 'appsec')
        using @['bsimm'],->
          @.path_Root.file_Name().assert_Is 'BSIMM-Graphs-Data'
          @.path_Teams.file_Name().assert_Is 'teams'
          @.path_Teams.assert_Is @.path_Root.path_Combine 'teams'
          @.path_Teams.assert_Folder_Exists()
          @.data.key.assert_Is project
      

  it 'ids', ->
    using data_Project, ->
      @.ids().assert_Contains(project, 'appsec')
      
   
      