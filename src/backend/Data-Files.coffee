Data    = require '../data/Data'

class Data_Files
  constructor: (options)->
    #@.options = options || {}      
    @.data    = new Data()

  get_File_Data: (filename) ->
    @.data.find filename
    
  list: ()->
    @.data.files().file_Names()

module.exports = Data_Files