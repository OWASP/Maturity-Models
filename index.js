require('coffee-script/register')
D3_Server = require('./src/D3-Server')

d3_server = new D3_Server()
d3_server.run()
console.log("Server started on" +  d3_server.server_Url())
