Array::duplicates =  ()-> @.filter (x, i, self) ->
  self.indexOf(x) == i && i != self.lastIndexOf(x)


String::folders_Recursive     = (extension)->
  folders = []
  for item in @.str().folders()
    folders = folders.concat(item.folders_Recursive(extension))
    folders.push(item)

  return folders

Array::folder_Names = Array::file_Names

Number::random_Chars = ->
  "".add_Random_Chars(@ + 0)

 
#see https://twitter.com/DinisCruz/status/745283929142398976
Number::to_Decimal = -> Number.parseFloat(@.toFixed(4))