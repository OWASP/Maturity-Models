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
        @['level_1'].matches = @['level_1'].matches.size()    # hack to make the check below ,ore table
        @['level_2'].matches = @['level_2'].matches.size()
        @['level_3'].matches = @['level_3'].matches.size()
        @.assert_Is  { 'level_1':
                          value: 13.6,
                          percentage: '49%',
                          matches: 28
                        'level_2':
                          value: 11.8
                          percentage: '51%'
                          matches:23
                        'level_3':
                          value: 5
                          percentage: '56%'
                          matches:9 }

  it 'team_Score (no project or team)', ->
    using data_Stats, ->
      using @.team_Score(),->
        @.assert_Is {}
  
  it 'teams_Scores', ->
    using data_Stats, ->
      using @.teams_Scores(project),->
        @[team].level_1.value.assert_Is 13.6 