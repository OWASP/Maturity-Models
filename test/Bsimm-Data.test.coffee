Bsimm_Data = require '../src/Bsimm-Data'

describe 'Bsimm-Data',->
  it 'constructor', ->
    Bsimm_Data.assert_Is_Function()        
    using new Bsimm_Data(), ->
      @.data_Path.assert_Contains 'data'
                 .assert_Folder_Exists()

  it 'data_Files', ->
    using new Bsimm_Data(), ->
      @.data_Files().assert_Not_Empty()

  it 'data', ->
    using new Bsimm_Data(), ->
      data  = @.data().assert_Not_Empty()
      using data, ->
        console.log data.size()
        @.first().user.assert_Is 'test'
        @.second().user.assert_Is 'in coffee'
        @.third().user.name.assert_Is 'Joe'
        #console.log @.second()