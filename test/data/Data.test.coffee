Data = require '../../src/data/Data'

describe 'Data',->
  it 'constructor', ->
    Data.assert_Is_Function()
    using new Data(), ->
      @.data_Path.assert_Contains 'data'
                 .assert_Folder_Exists()

  it 'files', ->
    using new Data(), ->
      @.files().assert_Not_Empty()
      @.files().first().assert_File_Not_Exists()
      @.files().first().assert_File_Not_Exists()
      @.data_Path.path_Combine(@.files().first()).assert_File_Exists()

  it 'files_Paths', ->
    using new Data(), ->
      @.files().size().assert_Is_Not @.files_Paths().size()
      @.files_Paths().assert_Not_Empty()
      @.files_Paths().first().assert_File_Exists()

  it 'data', -> 
    using new Data(), ->
      data  = @.data().assert_Not_Empty()
      using data, ->
        @.first().user.assert_Is 'test'
        @.second().user.assert_Is 'in coffee'
        @.third().user.name.assert_Is 'Joe'