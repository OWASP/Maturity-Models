#!/usr/bin/env coffee
require 'fluentnode'
D3_Server = require './src/D3-Server'

using new D3_Server(), ->
  @.run()
  console.log "Server started on #{@.server_Url()}"
