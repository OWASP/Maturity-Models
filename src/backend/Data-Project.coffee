class Data_Project
  constructor: ()->
    @.data_Path       = __dirname.path_Combine('../../data')
    @.config_File     = "maturity-model.json"
    @.schema_File     = "schema.json"

  project_Files: (id)=>                                        # todo: refactor to make code clear
    return using (@.projects()[id]),->
      values = []
      if @?.path_Teams          
          for file in @.path_Teams.files_Recursive()
            if file.file_Extension() in ['.json', '.coffee']
              #if file.not_Contains 'maturity-model.json'
                values.push file
      return values

  project_Schema: (id)=>
    return using (@.projects()[id]),->
      if @.path_Schema?.file_Exists()
          return @.path_Schema.load_Json()
      return {}  
    
  # returns a list of current projects (which are defined by a folder containing an maturity-model.json )  
  projects: ()=>
    projects = {}
    for folder in @.data_Path?.folders_Recursive()
      config_File = folder.path_Combine @.config_File
      if config_File.file_Exists()
        data = config_File.load_Json()
        if data and data.key
          projects[data.key] = 
            path_Root  : folder
            path_Config: folder.path_Combine @.config_File
            path_Schema: folder.path_Combine @.schema_File
            path_Teams : folder.path_Combine 'teams'
            data: data    
    projects

  ids: ()=>
    @.projects()._keys()
      
module.exports = Data_Project

 