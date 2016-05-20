
describe 'prod | server-status', ->
  target_Server = 'http://178.62.104.128'

  it 'connect to target server', (done)->
    #target_Server.GET (data)->
    #  data.assert_Is 'Found. Redirecting to d3-radar'
      done()