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
      @.project_Files(project).file_Names().assert_Contains [ 'empty.json', 'save-test.json','team-A.json',
                                                              'team-B.json', 'team-C.json', 'team-random.coffee' ]
      @.project_Files('aa').assert_Is []
      
  it 'project_Schema', ->
    using data_Project, ->
      schema = @.project_Schema project
      using schema, ->
        @.domains._keys()                           .assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment'                           ]
        @.domains.Governance.practices              .assert_Is [ 'Strategy & Metrics', 'Compliance & Policy', 'Training'                                  ]
        @.practices._keys()                         .assert_Is [ 'Strategy & Metrics', 'Compliance & Policy',
                                                                 'Training','Attack Models', 'Security Features & Design',
                                                                 'Standards & Requirements', 'Architecture Analysis', 'Code Review',
                                                                 'Security Testing', 'Penetration Testing', 'Software Environment', 'Configuration Management & Vulnerability Management' ]
        @.practices['Strategy & Metrics'].key       .assert_Is   'SM'
        @.practices['Strategy & Metrics'].activities.assert_Is [ 'SM.1.1', 'SM.1.2', 'SM.1.3', 'SM.1.4', 'SM.2.1', 'SM.2.2', 'SM.2.3',
                                                                 'SM.2.5', 'SM.2.6', 'SM.3.1', 'SM.3.2'                                                   ]

        @.activities['SM.1.1']                       .assert_Is {level: '1', name: 'Publish process (roles, responsibilities, plan), evolve as necessary' }
        @.activities['SM.1.2']                       .assert_Is {level: '1', name: 'Create evangelism role and perform internal marketing'                }

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
      
   
      