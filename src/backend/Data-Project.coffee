class Data_Project
  constructor: ()->
    @.data_Path   = __dirname.path_Combine('../../data')
    @.config_File = "maturity-model.json" 
  list: ()->
    projects = []
    for folder in @.data_Path.folders()
      folder
      

module.exports = Data_Project