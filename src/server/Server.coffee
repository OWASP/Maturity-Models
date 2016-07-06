require 'fluentnode'

FileStreamRotator = require('file-stream-rotator')

express           = require 'express'
load              = require 'express-load'
bodyParser        = require('body-parser');
d3                = require 'd3'
morgan            = require 'morgan'
cheerio           = require 'cheerio'
Routes            = require './Routes'
Redirects         = require './Redirects'

require 'fluentnode'

class Server
  constructor: (options)->
    @.app     = null
    @.options = options || {}
    @.server  = null
    @.port    = @.options.port || process.env.PORT || 3000

  setup_Server: =>    
    @.app = express()
    @.app.d3 = d3

    #bodyParser
    @.app.use bodyParser.json()

    # test route
    @.app.get '/ping'      , (req, res) => res.end      'pong'
    @

  add_Angular_Route: ()=>
    @.app.get '/view*'        , (req, res) => res.sendFile __dirname.path_Combine('../../ui/.dist/html/index.html')
    @

  add_Bower_Support: ()=>
    @.app.use '/lib',  express.static __dirname.path_Combine('../../ui/bower_components')
    @.app.use '/ui' ,  express.static __dirname.path_Combine('../../ui/.dist')
    @

  add_Controllers: ->
    api_Path  = '/api/v1'
    Api_Data    = require '../controllers/Api-Data'             # Refactor how controllers are loaded #96
    Api_Team    = require '../controllers/Api-Team'
    Api_Logs    = require '../controllers/Api-Logs'
    Api_Project = require '../controllers/Api-Project'
    Api_Routes  = require '../controllers/Api-Routes'

    @.app.use api_Path , new Api_Data(   ).add_Routes().router
    @.app.use api_Path , new Api_Logs(   ).add_Routes().router
    @.app.use api_Path , new Api_Team(   ).add_Routes().router
    @.app.use api_Path , new Api_Project().add_Routes().router
    
    @.app.use api_Path , new Api_Routes(app:@.app).add_Routes().router
    @
    
  add_Redirects: ->
    new Redirects(app:@.app).add_Redirects()
    @

  setup_Logging: =>
    fs = require 'fs'
    @.logs_Folder  = __dirname.path_Combine('../../logs')
    #console.log 'LOGS Folder: ' + @.logs_Folder
    if @.logs_Folder.folder_Not_Exists()               # note: docker was having a problem with the creation of this folder
      @.logs_Folder.folder_Create()                    #       which is why this is now done on the Docker file (need to find root cause)
                                                       # Issue: Find root cause of logs folder not created in docker #97

    @.logs_Options =
      date_format: 'YYYY_MM_DD-hh_mm',
      filename   : @.logs_Folder + '/logs-%DATE%.log',
      frequency  : '12h',
      verbose    : false

    @.logs_Stream = FileStreamRotator.getStream @.logs_Options
    @.logs_Morgan = morgan 'combined', { stream: @.logs_Stream }
    @.app.use @.logs_Morgan


  start_Server: =>
    @.server = @.app.listen @.port
  
  server_Url: =>
    "http://localhost:#{@.port}"

  routes: =>    
    new Routes(app:@.app).list()
      
  run: (random_Port)=>
    if random_Port
      @.port = 23000 + 3000.random()
    @.setup_Server()
    @.setup_Logging()
    @.add_Angular_Route()
    @.add_Bower_Support()
    @.add_Controllers()
    @.add_Redirects()
    @.start_Server()

  stop: (callback)=>
    if @.server
      @.server.close =>
        callback() if callback    

  get_Html: (virtual_Path, callback)->
    @.server_Url().add(virtual_Path).GET (data)->
      if data 
        $ = cheerio.load(data)
      callback $, data


module.exports = Server