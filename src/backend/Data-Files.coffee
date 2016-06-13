Data_Project = require './Data-Project'

class Data_Files
  constructor: ()->
    #@.data_Path = __dirname.path_Combine('../../data')
    @.data_Project = new Data_Project();

#  all_Data: =>
#    values = []
#    for file in @.files()
#      value = @.data(file)
#      if value
#        values.add value
#    return values

  data: (file)=>
    if file
      switch file.file_Extension()
        when '.json'
          return file.load_Json()
        when '.coffee'                                # Issue 69 - Support for coffee file to create dynamic data set's allow RCE
          try
            data_Or_Function = require(file)
            if data_Or_Function instanceof Function   # check if what was received from the coffee script is an object or an function
              return data_Or_Function()
            else
              return data_Or_Function
          catch err
            console.log err                           # need better solution to log these errors
    return null
    return values


#  files: =>
#    project_Key = null
#    @.data_Project.project_Files(project_Key)
    
  files_Names: =>
    (file.file_Name_Without_Extension() for file in @.files_Paths())

  files_Paths: =>
    project_Key = null
    @.data_Project.project_Files(project_Key)
    #@.data_Path.files_Recursive()

  find_File: (filename)=>                                 # todo: (add DoS ticket) this method need caching since it will search all files everytime (could also be a minor DoS issue)
    if filename
      for file in @.files_Paths()                          # this can be optimized with a cache
        if file.file_Name_Without_Extension() is filename
          return file          
    return null

  get_File_Data: (filename) ->
    @.data @.find_File filename

#  files: =>
#    values = []
#    for file in @.data_Path.files_Recursive()
#      if file.file_Extension() in ['.json', '.json5', '.coffee']
#        if file.not_Contains 'maturity-model'
#          values.push file.remove(@.data_Path)
#    values

  # Issue 26 - Data_Files.set_File_Data - DoS via file_Contents
  set_File_Data_Json: (filename, json_Data) ->
    if not filename or not json_Data                    # check if both values are set
      return null

    if typeof json_Data isnt 'string'                   # check if file_Contents is a string
      return null

    try                                                 # confirm that json_Data parses OK into JSON
      JSON.parse json_Data                              
    catch      
      return null
    
    file_Path = @.find_File filename                    # resolve file path based on file name

    if file_Path is null or file_Path.file_Not_Exists() # check if was able to resolve it
      return null

    if file_Path.file_Extension() isnt '.json'          # check that the file is .json
      return null


    file_Path.file_Write json_Data                      # after all checks save file 

    return file_Path.file_Contents() is json_Data       # confirm file was saved ok
    
module.exports = Data_Files