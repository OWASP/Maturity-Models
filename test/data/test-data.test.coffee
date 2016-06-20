require('coffee-script/register')     # needed for wallaby execution (since it is running from compiled js)

describe 'data | test-data', ->

  it 'load data', ->
    data_File = './data/BSIMM-Graphs-Data/teams/for-dev/coffee-data.coffee'.real_Path()
    data_File.assert_File_Exists()
    data = require data_File
    data.assert_Is_Object()
    data.user.assert_Is 'in coffee'