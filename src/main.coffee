require './extra.methods'
Server = require('./server/Server');

start_Server = (options)->
  console.log 'start server'
  console.log('Staring bsimm-graph server')

  using new Server(options), ->
    @.run();
    console.log("Server started on " +  @.server_Url());
    return @

module.exports = start_Server