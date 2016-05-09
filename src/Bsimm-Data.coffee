require('coffee-script/register');
json5 = require 'json5'

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
          values.add file.load_Json()
        when '.json5'
           values.add json5.parse file.file_Contents()
        when '.coffee'
          values.add require file
          
    return values
      
module.exports = Bsimm_Data