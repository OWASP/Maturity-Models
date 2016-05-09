class Bsimm_Data
  constructor: ->
    @.data_Path = __dirname.path_Combine('../data')
  
  data_Files: =>
    @.data_Path.files_Recursive()
  
  data: =>
    values = []

    for file in @.data_Files()
      switch file.file_Extension()
        when '.json'
          values.push file.load_Json()            
        when '.json5'
           console.log 'json5'

    return values
      
module.exports = Bsimm_Data