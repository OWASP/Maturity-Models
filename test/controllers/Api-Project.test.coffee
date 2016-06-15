Api_Project = require '../../src/controllers/Api-Project'
#Server   = require '../../src/server/Server'

describe 'controllers | Api-Project', ->
  #app      = null
  api_Project = null

  before ->
    using new Api_Project(), ->
      api_Project = @

  it 'constructor', ->
    using api_Project, ->
      @.constructor.name.assert_Is 'Api_Project'      
      @.data_Project.constructor.name.assert_Is 'Data_Project'
      @.router.assert_Is_Function()

  it 'add_Routes', ()->
    using new Api_Project(), ->
      @.add_Routes()
      @.router.stack.assert_Size_Is 1

  it 'list', ()->
    res =
      json: (data)->
        data.assert_Contains ['demo', 'appsec']

    using new Api_Project(), ->
      @.list(null, res)

