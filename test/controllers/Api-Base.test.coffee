Api_Base = require '../../src/controllers/Api-Base'

describe 'controllers | Api-Base', ->
  api_Base = null

  beforeEach ->
    api_Base = new Api_Base()

  it 'constructor',->
    using api_Base, ->
      @.constructor.name.assert_Is 'Api_Base'

  it 'add_Route', ->
    using api_Base, ->
      action = ->
      @.add_Route 'get', '/aaaa', action
      @.routes_Added.assert_Is [ { method: 'get', path: '/aaaa', action: action} ]      

      @.add_Route 'aaa'             # should not work since method aaa doesn't exist
      @.routes_Added.assert_Size_Is 1
      @.add_Route 'aaa', 'bbb'      # should not work since action is not provided
      @.routes_Added.assert_Size_Is 1

  it 'routes_Stack', ->
    using api_Base, ->
      @.add_Route 'get', '/aaaa', ->
      using @.routes_Stack(), ->
        @.assert_Size_Is(1)
        using @.first(), ->
          @.regexp.assert_Is /^\/aaaa\/?$/i
          @.route.path.assert_Is '/aaaa'
          @.route.methods.assert_Is { get : true }
