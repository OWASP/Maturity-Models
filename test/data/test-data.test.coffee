describe 'data | test-data', ->

  it 'load data', ->
    data = require '../../data/BSIMM-Graphs-Data/test-data.coffee'
    data.assert_Is_Object()
    data.user.assert_Is 'in coffee'