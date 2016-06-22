Api_Base   = require './Api-Base'
Data_Files  = require '../backend/Data-Files'
Routes      = require '../server/Routes'
#express     = require 'express'

class Api_Team extends Api_Base
  constructor: (options)->
    @.options    = options || {}
    #@.router     = express.Router()
    @.data_Files = new Data_Files()
    super()

  add_Routes: ()=>
    @.add_Route 'get' , '/team/:project/list'      , @.list
    @.add_Route 'get' , '/team/:project/get/:team' , @.get
    @.add_Route 'post', '/team/:project/save/:team', @.save
    @

  get: (req, res)=>
    project = req.params?.project
    team    = req.params?.team                            # get team name from path
                                                          # validation is needed here, see https://github.com/DinisCruz/BSIMM-Graphs/issues/18
    data = @.data_Files.get_File_Data project, team       # get data
    if data
      res.setHeader('Content-Type', 'application/json');  # todo: need default way to handle this type of responses
      
      if req.query?.pretty is ""                          # todo: this should also be handled in better way (same as above)
        return res.send data.json_Pretty()
      else
        return res.send data
    else
      res.send { error: 'not found'}

  list: (req, res)=>
    project = req.params?.project
    res.send @.data_Files.files_Names(project)

  save: (req, res)=>
    project  = req.params?.project
    filename = req.params?.team                                  # get filename from QueryString
    if typeof req.body is 'object'
      data = req.body.json_Pretty()
    else
      data = req.body                                             # from post body
    if filename and data                                          # check that both exist
      if @.data_Files.set_File_Data_Json project, filename, data  # if set_File_Data_Json was ok
        return res.send status: 'file saved ok'                   # send an ok status
    res.send error: 'save failed'                                 # if something failed send generic error message

module.exports = Api_Team











