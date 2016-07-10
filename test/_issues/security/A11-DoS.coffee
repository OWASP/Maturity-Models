Data_Files = require '../../../src/backend/Data-Files'


describe '_security | A11 - DoS', ->

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/121
  it 'Issue 121 - Race condition on set_File_Data_Json method', ->

    console.log '123'