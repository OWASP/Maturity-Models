describe 'data | test-data', ->

  it 'load team-random data', ->
    data_File = './data/BSIMM-Graphs-Data/teams/team-random.coffee'.real_Path()
    data_File.assert_File_Exists()
    data = require(data_File)()
    data.assert_Is_Object()
    data.metadata.team.assert_Is 'Team Random'

  it '(regression) Issue #113 - Upgrade team data to latest schema (check all json files)', ->

    check_Folder = (teams_Data, domains_Names)->
      files = teams_Data.files_Recursive('.json')
      for file in files
        file_Data = file.load_Json()
        file_Data.activities?._keys().assert_Is_Bigger_Than 4
                                     .assert_Not_Contains 'Governance'

    check_Folder './data/BSIMM-Graphs-Data/teams'
    check_Folder './data/OpenSAMM-Graphs-Data/teams'

  it '(regression) Issue #113 - Upgrade team data to latest schema (check coffee files)', ->
    teams_Data = './data/BSIMM-Graphs-Data/teams'
    files = teams_Data.files_Recursive('.coffee')
    for file in files
      data = require(file)()
      data.activities._keys().assert_Is_Bigger_Than 4
                             .assert_Not_Contains 'Governance'
