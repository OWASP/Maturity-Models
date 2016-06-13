class Data_Project
  constructor: ()->
    @.data_Path   = __dirname.path_Combine('../../data')
    @.config_File = "maturity-model.json"

  # returns a list of current projects (which are defined by a folder containing an maturity-model.json )
  projects: ()=>
    projects = {}
    for folder in @.data_Path.folders_Recursive()
      config_File = folder.path_Combine @.config_File
      if config_File.file_Exists()
        data = config_File.load_Json()
        if data and data.key
          projects[data.key] = 
            path: folder
            data: data    
    projects

  projects_Keys: ()=>
    @.projects()._keys()
      

module.exports = Data_Project