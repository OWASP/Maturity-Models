json5   = require 'json5'


class Data_Files
  constructor: (options)->
    #@.options = options || {}      
    #@.data      = new Data()
    @.data_Path = __dirname.path_Combine('../../data')

  all_Data: =>
    values = []
    for file in @.files_Paths()
      value = @.data(file)
      if value
        values.add value

    return values

  data: (file)=>
    if file
      switch file.file_Extension()
        when '.json'
          file.load_Json()
        when '.json5'
          json5.parse file.file_Contents()
        when '.coffee'

          data_Or_Function = require(file)
          if data_Or_Function instanceof Function   # check if what was received from the coffee script is an object or an function
            return data_Or_Function()
          else
            return data_Or_Function

  files_Names: =>
    (file.file_Name_Without_Extension() for file in @.files())

  files_Paths: =>
    @.data_Path.files_Recursive()

  find: (filename)=>
    if filename
      for file in @.files_Paths()                          # this can be optimized with a cache
        if file.file_Name_Without_Extension() is filename
          return @.data(file)
    return null

  get_File_Data: (filename) ->
    @.find filename

  #set_File_Data: fileName

  #list: ()=>
  #  @.files().file_Names()
    
  files: =>
    values = []
    for file in @.data_Path.files_Recursive()
      if  file.file_Extension() in ['.json', '.json5', '.coffee']
        values.push file.remove(@.data_Path)
    values


module.exports = Data_Files