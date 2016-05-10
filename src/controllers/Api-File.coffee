express = require 'express'

class Api_File
  constructor: ->
    @.router = express.Router()

module.exports = Api_File