express = require 'express'

class File_Controller
  constructor: ->
    @.router = express.Router()

module.exports = File_Controller