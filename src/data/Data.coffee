require('coffee-script/register')
json5 = require 'json5'

class Data
  constructor: ->
    @.data_Path = __dirname.path_Combine('../../data')


      
module.exports = Data