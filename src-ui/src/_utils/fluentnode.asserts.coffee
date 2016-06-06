#asserts

if window['chai']     # need to move this to a separate file only available during tests

  expect = chai.expect

  Object.defineProperty Object.prototype, 'assert_Is',
    enumerable  : false,
    writable    : true,
    value: (target)->
      expect(@).to.deep.equal(target)
      @

  String::assert_Is          = (target, message)->
    expect(@.toString()).to.equal(target, message)
    @


  String::assert_Contains = (target, message)->
    source    = @.toString()
    message   = message || "expected string '#{source}' to contain the string/array '#{target}'"
    expect(source).to.contain(target, message)
    @

  String::assert_Not_Contains         = (target)->
    source    = @.toString()
    message   = "expected string '#{source}' to not contain the string '#{target}'"
    expect(source).to.not.contain(target,message)
    @

  Number::assert_Is          = (target, message)->      # slight modified from fluentnode version
    expect(@.toString()).to.equal(target.toString(), message)
    @

  Boolean::assert_Is_False = ->
    expect(@.valueOf()).to.equal(false)
    return false

  Boolean::assert_Is_True = ->
    expect(@.valueOf()).to.equal(true)
    return true

  Array::assert_Contains = (value, message)->
    message = message || "[assert_Contains]"
    if value instanceof Array
      for item in value
        @.contains(item).assert_Is_True("#{item} not found in array: #{@}")
    else
      @.contains(value).assert_Is_True(message)
    @