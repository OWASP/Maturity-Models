require '../../src/extra.methods'
Data_Project = require '../../src/backend/Data-Project'
async        = require 'async'

# These tests represent regression tests for DoS attacks

describe '_regression | A11 - DoS', ->

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/72
  it 'Issue 72 - Project list gets data from File System and could cause DoS', ()->
    using new Data_Project(), ->
      start = Date.now();
      test_List = (index, next)=>
        @.projects().assert_Is_Object()
        next()

      #items = [0..0     ]   # 1 takes 15ms
      items = [0..10   ]   # 10 takes 50ms
      #items = [0..100  ]   # 100 takes 250ms
      #items = [0..1000 ]   # 1000 takes 2250ms
      #items = [0..5000 ]   # 5000 takes 1200ms
      async.each items, test_List, ->
        duration = Date.now() - start
        duration.assert_In_Between(30,120)


