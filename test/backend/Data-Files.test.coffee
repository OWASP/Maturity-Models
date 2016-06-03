Data_Files = require '../../src/backend/Data-Files'

describe 'controllers | Api-Controller', ->
  data_Files = null

  beforeEach ->
    data_Files = new Data_Files()

  it 'constructor',->
    using data_Files, ->
      @.constructor.name.assert_Is 'Data_Files'      
      @.data_Path.assert_Contains 'data'
                 .assert_Folder_Exists()

  it 'all_Data', ->
    using data_Files, ->
      data  = @.all_Data().assert_Not_Empty()
      using data, ->
        @.first( ).user.assert_Is 'in coffee'
        @.second().user.assert_Is 'test'
        @.third( ).user.name.assert_Is 'Joe'
        
  it 'files', ->
    using data_Files, ->
      @.files().assert_Not_Empty()
      @.files().first().assert_File_Not_Exists()
      @.files().first().assert_File_Not_Exists()
      @.data_Path.path_Combine(@.files().first()).assert_File_Exists()

  it 'files_Names', ->
    using data_Files, ->
      @.files_Names().assert_Not_Empty()
      @.files_Names().first().assert_Is @.files().first().file_Name_Without_Extension()


  it 'files_Paths', ->
    using data_Files, ->
      @.files().size().assert_Is_Not @.files_Paths().size()
      @.files_Paths().assert_Not_Empty()
      @.files_Paths().first().assert_File_Exists()
      
  it 'get_File_Data', ()->
    filename = 'json-data'
    using data_Files, ->
      @.get_File_Data(filename)
          .user.name.assert_Is 'Joe'

  it 'set_File_Data', ()->
    filename = 'temp_file.json'
    contents = '{ aaa : 123 }'
    using data_Files, ->
      file_Path = @.set_File_Data filename, contents
      console.log file_Path
      file_Path.assert_File_Exists() 
 
  it 'set_File_Data (bad data)', ()->
    using data_Files, ->
      assert_Is_Null @.set_File_Data()
      assert_Is_Null @.set_File_Data 'aaa'
      assert_Is_Null @.set_File_Data null, 'bbbb'
      assert_Is_Null @.set_File_Data 'aaa', {}