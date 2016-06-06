# Fluentnode extension methods (these need to be moved into a separate module or service

Array::contains = (value)->
  if value instanceof Array
    for item in value
      if not (item in @)
        return false
    return true;
  else
  (value in @)

Array::first  = ->
  @.item(0)


Array::item = (index)->
  if typeof(index) is 'number'
    if @.length > index > -1
      return @[index]
  null

Array::size = () ->
  @.length

Array::take = (size) ->
  if size is -1 then @ else @.slice(0,size)

String::remove = (value)->
  result = @
  while result.contains(value)
    result = result.replace(value,'')
  result

String::contains = (value)->
  if value instanceof RegExp
    regex = new RegExp(value)
    return regex.exec(@) isnt null
  if value instanceof Array
    for item in value
      if @.indexOf(item) is -1
        return false
    return true
  @.indexOf(value) > -1

# not in fluent node

#String::upper_Case_First_Letter = ()->
#  @.charAt(0).toUpperCase() + @.substr(1)


Object.defineProperty Object.prototype, 'keys',
  enumerable  : false,
  writable    : true,
  value: ->
    return (key for own key of @)


#globals
  window.using = (target,callback)->
    callback.apply(target)