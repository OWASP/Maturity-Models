require '../src/extra.methods'

describe 'extra.methods', ->
  it 'duplicates', ->
    [1,2,3].duplicates().assert_Is []
    [1,2,2].duplicates().assert_Is [2]
    
  it 'folder_Recursive', ->
    './data'.folders_Recursive().folder_Names().assert_Size_Is_Bigger_Than 3

    
  it 'folder_Names', ->
    '.'.folders().file_Names().assert_Is '.'.folders().folder_Names()