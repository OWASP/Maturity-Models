Data_Files = require '../../src/backend/Data-Files'

Number::random_Chars = ->
  "".add_Random_Chars(@ + 0)

# These tests represent Injections Security Issues
# See https://www.owasp.org/index.php/Top_10_2013-A1-Injection for more references
describe '_security | A1 - Injection', ->

  # todo: fix this test since it is testing the wrong thing.
  #       with the fix for #19 this test now needs to focus on changing the file contents of an existing file
  # https://github.com/DinisCruz/BSIMM-Graphs/issues/20
  xit 'Issue 20 - Data_Files.set_File_Data - DoS via filename and file_Contents', ->
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
        else                                                  # if not
          file_Path.assert_File_Not_Exists()                  #   confirm creation failed


      # testing multiple file sizes (before fix the first 3 where true)
      create_File 10 ,10 , false
      create_File 100,10 , false
      create_File 156,10 , false
      #create_File 157,10 , false                             # interesting in wallaby, after 156 chars it doesn't work
      #create_File 208,10 , false                             #             in mocha, it's after 208
      create_File 512,10 , false                              #             in travis the number is really higher (not sure about the exact one)

      # testing multiple file contents (before fix all where true)
      create_File 10 ,10      , false                         # 10 bytes
      create_File 10 ,100     , false                         # 100 bytes
      create_File 10 ,10000   , false                         # 10 Kb
      create_File 10 ,1000000 , false                         # 1 Mb
  #create_File 10 ,10000000 , true                        # 10 Mb - will work and take about 250 ms
  #create_File 10 ,100000000 , true                       # 100 Mb - will work and take about 2 secs

