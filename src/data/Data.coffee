require('coffee-script/register')
json5 = require 'json5'

class Data
  constructor: ->
    @.data_Path = __dirname.path_Combine('../../data')
  
  files: =>
    values = []
    for file in @.data_Path.files_Recursive()
      if  file.file_Extension() in ['.json', '.json5', '.coffee']
        values.push file.remove(@.data_Path)
    values

  files_Paths: =>
    @.data_Path.files_Recursive()

  data: =>
    values = []

    for file in @.files_Paths()
      switch file.file_Extension()
        when '.json'
          values.add file.load_Json()
        when '.json5'
          values.add json5.parse file.file_Contents()
        when '.coffee'
          values.add require file
          
    return values
      
module.exports = Data