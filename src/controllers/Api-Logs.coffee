Api_Base = require './Api-Base'

class Api_Logs extends Api_Base
  constructor: (options)->
    @.options     = options || {}
    @.logs_Folder = __dirname.path_Combine('../../logs')      # todo: use this has the global location of this value
    super()

  add_Routes: ()=>
    @.add_Route 'get', '/logs/path'       , @.path
    @.add_Route 'get', '/logs/list'       , @.list
    @.add_Route 'get', '/logs/file/:index', @.file
    @

  list: (req, res)=>
    res.send @.logs_Folder.files().file_Names()

  file: (req, res)=>
    index = parseInt(req.params?.index)
    if is_Number(index)
      file_Name = @.logs_Folder.files().file_Names()[index]
      if file_Name
        file_Path = @.logs_Folder.path_Combine file_Name        
        if file_Path.file_Exists()
          return res.send  file_Path.file_Contents()

    res.send 'not found'    

  path: (req, res)=>
    res.send @.logs_Folder


module.exports = Api_Logs    