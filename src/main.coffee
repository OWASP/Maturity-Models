D3_Server = require('./server/D3-Server');

start_Server = (options)->
  console.log 'start server'
  console.log('Staring bsimm-graph server');

  using new D3_Server(options), ->
    @.run();
    console.log("Server started on " +  @.server_Url());
    return @

module.exports = start_Server