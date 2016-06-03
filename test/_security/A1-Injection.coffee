Data_Files = require '../../src/backend/Data-Files'

Number::random_Chars = ->
  "".add_Random_Chars(@ + 0)

# These tests represent Injections Security Issues
# See https://www.owasp.org/index.php/Top_10_2013-A1-Injection for more references
describe '_securtiy | A1 - Injection', ->

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/21
  it 'Issue 19 - Data_Files.set_File_Data - Path Traversal', ->    
    using new Data_Files(), ->
      folder_Name  = 'outside-data-root'
      file_Name    = 'some-file.txt'
      file_Content = 'some content'
      target_Folder = @.data_Path.path_Combine('../' + folder_Name)        # Create target folder
                                 .folder_Create()
                                 .assert_Folder_Exists()                   # Confirm it exists
      
      target_Folder.path_Combine(file_Name)                                # Create target File
                   .file_Write(file_Content)
                   .assert_File_Exists()                                   # Confirm it exists

      payload     = "../#{folder_Name}/#{file_Name}"
      new_Content = 'new - content'

      @.data_Path.path_Combine(payload)
                 .file_Contents().assert_Is file_Content                   # Confirm original content is there

      @.set_File_Data payload, new_Content                                 # PAYLOAD: Create file outsite data root

      @.data_Path.path_Combine(payload)
                 .file_Contents().assert_Is_Not file_Content               # Confirm original content is NOT there
                                 .assert_Is new_Content                    # Confirm that it has been changed

      target_Folder.folder_Delete_Recursive().assert_Is_True()             # Delete temp folder

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/20
  it.only 'Issue 20 - Data_Files.set_File_Data - DoS via filename and file_Contents', ->

    # Create files with large strings
    using new Data_Files(), ->
      create_File = (file_Size, content_Size, should_Work)=>
        file_Name     = file_Size   .random_String()
        file_Contents = content_Size.random_String()
        file_Path     = @.data_Path .path_Combine(file_Name)

        file_Path.assert_File_Not_Exists()                    # confirm file doesn't exist

        @.set_File_Data file_Name, file_Contents              # PAYLOAD: create file

        if should_Work                                        # if it should work
          file_Path.assert_File_Exists()                      #   confirm file exists
          file_Path.file_Delete().assert_Is_True()            #   delete temp file
          file_Path.assert_File_Not_Exists()
        else                                                  # if not
          file_Path.assert_File_Not_Exists()                  #   confirm creation failed


      # testing multiple file sizes
      create_File 10 ,10 , true
      create_File 100,10 , true
      create_File 156,10 , true
      #create_File 157,10 , false                              # interesting in wallaby, after 156 chars it doesn't work
      create_File 208,10 , false                               #             in mocha, it's after 208
      return
      # testing multiple file contents
      create_File 10 ,10 , true
      create_File 10 ,100 , true
      create_File 10 ,10000 , true
      create_File 10 ,1000000 , true
