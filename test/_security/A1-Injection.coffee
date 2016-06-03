Data_Files = require '../../src/backend/Data-Files'

Number::random_Chars = ->
  "".add_Random_Chars(@ + 0)

# These tests represent Injections Security Issues
# See https://www.owasp.org/index.php/Top_10_2013-A1-Injection for more references
describe '_security | A1 - Injection', ->

  #NOTE: this file will modify the data file and will make WebStorm keep looping on test execution (wallaby seems to be ok with it)
  it 'Issue 24 - Data_Files.set_File_Data - allows editing of coffee-script files (RCE)', ->

    using new Data_Files(), ->
      # PREPARE
      new_File_Contents = 'module.exports = ()-> 40+2'
      file_Name         = 'coffee-data'
      file_Path         = @.find_File file_Name
      file_Contents = file_Path.file_Contents()
      @.get_File_Data(file_Name).user.assert_Is 'in coffee'        # confirm original data

      # TEST
      @.set_File_Data file_Name, new_File_Contents                 # PAYLOAD make change
      file_Path.file_Contents().assert_Is new_File_Contents        # confirm it was changed
      delete require.cache[file_Path]                              # clean the node cache
      @.get_File_Data(file_Name).assert_Is '42'                    # it should be 42 now (which means that the payload was executed

      # CLEAN
      @.set_File_Data file_Name, file_Contents                     # restore file contents
      file_Path.file_Contents().assert_Is file_Contents            # confirm it was reset ok
      delete require.cache[file_Path]                              # clear the cache again
      @.get_File_Data(file_Name).user.assert_Is 'in coffee'        # confirm original data
