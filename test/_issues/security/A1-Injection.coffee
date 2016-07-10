Data_Files = require '../../../src/backend/Data-Files'

# These tests represent Injections Security Issues
# See https://www.owasp.org/index.php/Top_10_2013-A1-Injection for more references
describe '_security | A1 - Injection', ->

  # https://github.com/DinisCruz/BSIMM-Graphs/issues/20
  it 'Issue 26 - Data_Files.set_File_Data - DoS via file_Contents', ->

    using new Data_Files(), ->
      project = 'bsimm'
      file_Name = "save-test"
      file_Path = @.find_File(project,file_Name)
      create_File = (size)=>
        new_File_Contents = { data: size.random_String() }.json_Str()
        file_Path.assert_File_Exists()                              # confirm file exist (since the current version only allows files to be modified

        @.set_File_Data_Json project,file_Name, new_File_Contents   # set file with json data
                  .assert_Is_True()

        file_Path.file_Contents().assert_Is  new_File_Contents      # confirm file was changed
                                 .assert_Size_Is (size + 11)        # to the expected size (+11 from json data field and padding)

      restore_File = ()=>
        original_Content = { "will-be": "changed by tests" }
        @.set_File_Data_Json project,file_Name, original_Content.json_Pretty()
            .assert_Is_True()

      # testing multiple file contents
      create_File 10 ,10                                            # 10 bytes
      create_File 10 ,100                                           # 100 bytes
      create_File 10 ,10000                                         # 10 Kb
      create_File 10 ,1000000                                       # 1 Mb
      #create_File 10 ,10000000 , true                              # 10 Mb - will work and take about 250 ms
      #create_File 10 ,100000000 , true                             # 100 Mb - will work and take about 2 secs
      restore_File()



