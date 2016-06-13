Array::duplicates =  ()-> @.filter (x, i, self) ->
  self.indexOf(x) == i && i != self.lastIndexOf(x)


String::folders_Recursive     = (extension)->
  folders = []
  for item in @.str().folders()
    folders = folders.concat(item.folders_Recursive(extension))
    folders.push(item)

  return folders

Array::folder_Names = Array::file_Names