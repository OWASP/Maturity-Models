Data_Stats = require '../../src/backend/Data-Stats'


describe 'backend | Data-Stats', ->
  data_Stats = null
  project    = null
  team       = null

  beforeEach ->
    project    = 'bsimm'
    team       = 'team-A'
    data_Stats = new Data_Stats()

  it 'constructor',->
    using data_Stats, ->
      @.constructor.name.assert_Is 'Data_Stats'
      @.data_Files  .constructor.name.assert_Is 'Data_Files'
      @.data_Project.constructor.name.assert_Is 'Data_Project'
      
  it 'team_Score', -> 
    using data_Stats, ->
      using @.team_Score(project, team),->
        @.assert_Is  { 'level_1':
                          value     : 10.6,
                          percentage: '38%',
                          activities: 28
                        'level_2':
                          value     : 8.8
                          percentage: '38%'
                          activities :23
                        'level_3':
                          value: 3
                          percentage: '33%'
                          activities:9 }

  it 'team_Score (no project or team)', ->
    using data_Stats, ->
      using @.team_Score(),->
        @.assert_Is {}
  
  it 'teams_Scores', ->
    using data_Stats, ->
      using @.teams_Scores(project),->
        @[team].level_1.value.assert_Is 10.6