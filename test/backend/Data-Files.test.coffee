Data_Files = require '../../src/backend/Data-Files'

describe 'backend | Data-Files', ->
  data_Files = null
  project    = null

  beforeEach ->
    project    = 'bsimm'
    data_Files = new Data_Files()

  it 'constructor',->
    using data_Files, ->
      @.constructor.name.assert_Is 'Data_Files'

  it 'files_Names', ->
    using data_Files, ->
      @.files_Names(project).assert_Not_Empty()
      @.files_Names(project).first().assert_Is @.files_Paths(project).first().file_Name_Without_Extension()


  it 'files_Paths', ->
    using data_Files, ->
      @.files_Paths(project).assert_Not_Empty()
      @.files_Paths(project).first().assert_File_Exists()

  it 'find_File', ->
    using data_Files, ->
      team_A = @.find_File project, 'team-A'
      team_A.assert_File_Exists()

      assert_Is_Null @.find_File 'demo', 'Team-A'  # search is case sensitive
      assert_Is_Null @.find_File 'demo', 'aaaaaa'
      assert_Is_Null @.find_File 'demo', null
      assert_Is_Null  @.find_File null, 'team-A'
      assert_Is_Null @.find_File 'aaaa', 'team-A'

  it 'get_File_Data', ()->
    project  = 'bsimm'
    filename = 'team-A'
    using data_Files, ->
      @.get_File_Data project, filename
          .metadata.team.assert_Is 'Team A'

  it 'set_File_Data', ->
    project     = 'bsimm'
    target_File = 'team-C'
    good_Value  = 'Team C'
    temp_Value  = 'BBBBB'

    using data_Files.get_File_Data(project, target_File), ->                # get data
      @.metadata.team.assert_Is good_Value
      @.metadata.team        =  temp_Value                                  # change value
      data_Files.set_File_Data_Json project, target_File, @.json_Str()      # save it
                .assert_Is_True()                                           # confirm save was ok

    using data_Files.get_File_Data(project,target_File), ->                 # get new copy of data
      @.metadata.team.assert_Is temp_Value                                  # check value has been changed
      @.metadata.team         = good_Value                                  # restore original value
      data_Files.set_File_Data_Json project,target_File, @.json_Pretty()    # save it again

    using data_Files.get_File_Data(project,target_File), ->                 # get another copy of data
      @.metadata.team.assert_Is good_Value                                  # confirm original value is there

  it 'set_File_Data (bad json)', ()->
    target_File = 'team-C'
    bad_Json    = '{ not-good : json } '
    using data_Files, ->
      assert_Is_Null data_Files.set_File_Data_Json target_File, bad_Json

  it 'set_File_Data (not able to create new file)', ()->
    filename = 'temp_file.json'
    contents = '{ "aaa" : 123 }'
    using data_Files, ->
      @.set_File_Data_Json filename, contents
      assert_Is_Null @.get_File_Data filename, contents  
      
 
  it 'set_File_Data (bad data)', ()->
    using data_Files, ->
      assert_Is_Null @.set_File_Data_Json()
      assert_Is_Null @.set_File_Data_Json 'aaa'
      assert_Is_Null @.set_File_Data_Json null, 'bbbb'
      assert_Is_Null @.set_File_Data_Json 'aaa', {}
      
        

  