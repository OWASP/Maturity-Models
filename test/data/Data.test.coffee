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

  it 'files_Names', ->
    using new Data(), ->
      @.files_Names().assert_Not_Empty()
      @.files_Names().first().assert_Is @.files().first().file_Name_Without_Extension()


  it 'files_Paths', ->
    using new Data(), ->
      @.files().size().assert_Is_Not @.files_Paths().size()
      @.files_Paths().assert_Not_Empty()
      @.files_Paths().first().assert_File_Exists()

  it 'all_Data', ->
    using new Data(), ->
      data  = @.all_Data().assert_Not_Empty()
      using data, ->
        @.first( ).user.assert_Is 'in coffee'
        @.second().user.assert_Is 'test'
        @.third( ).user.name.assert_Is 'Joe'