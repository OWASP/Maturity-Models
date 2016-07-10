Data_Files = require '../../../src/backend/Data-Files'

#Number::random_Chars = ->
#  "".add_Random_Chars(@ + 0)

# These tests represent regression tests for Injection attacks

describe '_regression | A1 - Injection', ->

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/21
  it 'Issue 19 - Data_Files.set_File_Data - Path Traversal', ->
    using new Data_Files(), ->
      folder_Name  = 'outside-data-root'
      file_Name    = 'some-file.txt'
      file_Content = 'some content'
      data_Path    = @.data_Project.data_Path
      target_Folder = data_Path.path_Combine('../' + folder_Name)     # Create target folder
                               .folder_Create()
                               .assert_Folder_Exists()                # Confirm it exists

      target_Folder.path_Combine(file_Name)                           # Create target File
                   .file_Write(file_Content)
                  .assert_File_Exists()                               # Confirm it exists


      payload     = "../#{folder_Name}/#{file_Name}"
      payload_2   = "..\#{folder_Name}/#{file_Name}"                  # also trying with \
      payload_3   = "..\\#{folder_Name}/#{file_Name}"                 # also trying with \\

      new_Content = 'new - content'

      data_Path.path_Combine(payload)
               .file_Contents().assert_Is file_Content                # Confirm original content is there

      assert_Is_Null @.set_File_Data_Json payload  , new_Content      # PAYLOAD: Create file outsite data root (this should not work now)
      assert_Is_Null @.set_File_Data_Json payload_2, new_Content      #          with \ variation
      assert_Is_Null @.set_File_Data_Json payload_3, new_Content      #          with \\ variation

      data_Path.path_Combine(payload)
               .file_Contents().assert_Is file_Content                # Confirm original content is there (i.e. path outside web root was not modified)

      target_Folder.folder_Delete_Recursive().assert_Is_True()        # Delete temp folder

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/20
  it 'Issue 20 - Data_Files.set_File_Data - DoS via filename', ->
    using new Data_Files(), ->
      create_File = (file_Size, content_Size)=>
        file_Name     = file_Size   .random_String()
        file_Contents = content_Size.random_String()
        file_Path     = @.data_Project.data_Path .path_Combine(file_Name)

        file_Path.assert_File_Not_Exists()                    # confirm file doesn't exist

        @.set_File_Data_Json file_Name, file_Contents              # PAYLOAD: create file

        file_Path.assert_File_Not_Exists()                  #   confirm creation failed

      # testing multiple file sizes (before fix the first 3 where true)
      create_File 10 ,10 , false
      create_File 100,10 , false
      create_File 156,10 , false
      create_File 512,10 , false


  it 'Issue 23 - Data_Files.set_File_Data - allows creation of files with any extension', ->
    using new Data_Files(), ->
      create_File = (extension)=>
        file_Name     = 10.random_String() + extension
        file_Contents = 10.random_String()
        file_Path     = @.data_Project.data_Path.path_Combine(file_Name)

        @.set_File_Data_Json file_Name, file_Contents               # PAYLOAD: create file

        file_Path.assert_File_Not_Exists()                          # confirm file doesn't exists

      create_File '.json'                                           # confirm that none work now
      create_File '.json5'
      create_File '.coffee'
      create_File '.js'
      create_File '.exe'
      create_File '.html'
      create_File '.css'
      create_File '...'

  #require('coffee-script/register');          # in case wallably has not registered it
  it 'Issue 24 - Data_Files.set_File_Data - allows editing of coffee-script files (RCE)', ->
    using new Data_Files(), ->
      original_File_Contents = 'module.exports = ()-> user: 42'
      new_File_Contents      = 'module.exports = ()-> 40+2'
      project                = 'bsimm'
      file_Name              = 'test-coffee-data'
      target_Folder          = @.find_File(project, 'team-A').parent_Folder()

      file_Path              = target_Folder.path_Combine file_Name + '.coffee'

      original_File_Contents.save_As file_Path

      @.get_File_Data(project, file_Name).user.assert_Is 42                 # confirm original data

      result = @.set_File_Data_Json project, file_Name, new_File_Contents   # try to make change
      assert_Is_Null result                                                 # confirm save fail

      file_Path.file_Contents().assert_Is_Not new_File_Contents             # confirm data was NOT changed
                               .assert_Is     original_File_Contents
      file_Path.assert_File_Deleted()