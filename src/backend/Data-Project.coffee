class Data_Project
  constructor: ()->
    @.data_Path       = __dirname.path_Combine('../../data')
    @.config_File     = "maturity-model.json"
    @.default_Project = 'demo'

  project_Files: (project_Key)=>
    key = project_Key ||  @.default_Project           # todo: refactor to make it clear
    return using (@.projects()[key]),->
      project_Path = @.path
      if @.path
        values = []
        for file in project_Path.files_Recursive()
          if file.file_Extension() in ['.json', '.coffee']
            if file.not_Contains 'maturity-model'
              values.push file
        return values
      return null

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