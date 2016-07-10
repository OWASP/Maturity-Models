Data_Project = require './Data-Project'

class Data_Files
  constructor: ()->
    @.data_Project = new Data_Project();

    return null
    
  files_Names: (project)=>                  
    (file.file_Name_Without_Extension() for file in @.files_Paths(project))

  # Issue: DoS on Data-Project technique to map projects and project's teams #108
  files_Paths: (project)=>
    @.data_Project.project_Files(project)

  find_File: (project, filename)=>
    if filename
      for file in @.files_Paths(project)                   # this can be optimized with a cache
        if file.file_Name_Without_Extension() is filename
          return file          
    return null

  get_File_Data: (project, filename) ->
    file = @.find_File project, filename
    if file and file.file_Exists()
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


  # Issue 26 - Data_Files.set_File_Data - DoS via file_Contents
  # Issue 121 - Race condition on set_File_Data_Json method
  set_File_Data_Json: (project, filename, json_Data) ->
    if not filename or not json_Data                    # check if both values are set
      return null

    if typeof json_Data isnt 'string'                   # check if file_Contents is a string
      return null

    try                                                 # confirm that json_Data parses OK into JSON
      JSON.parse json_Data                              
    catch      
      return null
    
    file_Path = @.find_File project, filename           # resolve file path based on file name

    if file_Path is null or file_Path.file_Not_Exists() # check if was able to resolve it
      return null

    if file_Path.file_Extension() isnt '.json'          # check that the file is .json
      return null


    file_Path.file_Write json_Data                      # after all checks save file 

    return file_Path.file_Contents() is json_Data       # confirm file was saved ok
    
module.exports = Data_Files
