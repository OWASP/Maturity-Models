describe 'js-bug - Wrong value on Decimals addition', ->
  # the root cause of this issue is the fundamental prob of representing decimal values in binary
  #    http://trentrichardson.com/2013/02/23/why-you-cant-trust-javascripts-addition-nodejs-included/
  #    http://stackoverflow.com/questions/588004/is-floating-point-math-broken

  a = null
  b = null

  beforeEach ->
    a = 0.2
    b = 0.4

  it 'Confirming the problem', ->
    (0.2 + 0.4).assert_Is_Not (0.6000000000000000)        # I would expect this to be true
    (0.2 + 0.4).assert_Is_Not (0.6               )        # or this
    (0.2 + 0.4).assert_Is     (0.6000000000000001)        # but not this

    c = 0.6
    d = 0.6000000000000001
    (a+b is c).assert_Is_False()                          # again, I would expect this to be true
    (a+b == c).assert_Is_False()
    (a+b is d).assert_Is_True()                           # (0.2 + 0.4) should not be equal to 0.6000000000000001
    (c == d  ).assert_Is_False()                          # confirming they are different

    (a+b     ).assert_Is_Not c                            # another variation
    (a+b     ).assert_Is d                                # just confirming that it also happens with variables

  it 'using node native Number class (...same problem)', ->
    a = new Number(0.2)
    b = new Number(0.4)
    c = new Number(0.2) + new Number(0.4)
    a    .assert_Is 0.2
    b    .assert_Is 0.4
    c    .assert_Is 0.6000000000000001
    (a+b).assert_Is 0.6000000000000001

  it 'using toFixed (...getting there)', ->               # https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed
    c = (a+b).toFixed(2)                                  # this now produces the correct value
    c.assert_Is '0.60'                                    # but it is a string

    a = 0.2.toFixed(2)                                    # confirming that toFixed this will create a string
    b = 0.4.toFixed(2).assert_Is_String()
    c = a+c
    c.assert_Is '0.200.60'                                # what happens when one concats two strings

  it 'using toFixed with new Number (...just about working as expected)', ->
    c = a + b
    console.log  c
    using_new_Number = new Number(c.toFixed(2))
    using_new_Number.assert_Is 0.6                        # now we get the expected valuer
    using_new_Number.assert_Is_Object()
    (typeof using_new_Number).assert_Is 'object'          # but it is a bit weird why the type is object

  it 'using toFixed with new Number (....finally working as expected)', ->
    c = a + b
    using_parseFloat = Number.parseFloat(c.toFixed(2))
    using_parseFloat.assert_Is 0.6                        # now we get the expected valuer
    using_parseFloat.assert_Is_Object()
    (typeof using_parseFloat).assert_Is 'number'          # here is the type I was expecting

    # testing toFixed number of digits
    Number.parseFloat((0.2 + 0.4)           ).assert_Is 0.6000000000000001    # confirming that with just Number.parseFloat, it doesn't work
    Number.parseFloat((0.2 + 0.4).toFixed(2 )).assert_Is 0.6                  # with 2 decimal digits
    Number.parseFloat((0.2 + 0.4).toFixed(4 )).assert_Is 0.6
    Number.parseFloat((0.2 + 0.4).toFixed(10)).assert_Is 0.6
    Number.parseFloat((0.2 + 0.4).toFixed(15)).assert_Is 0.6                  # 15 seems to be the maximum number of decimal digits

    Number.parseFloat((0.2 + 0.4).toFixed(16)).assert_Is 0.6000000000000001   # with 16, where back to the bad value

  it 'testing extension method solution', ->
    # added to extra.methods.coffee file (and eventually to fluentnode)
    #Number::to_Decimal = -> Number.parseFloat(@.toFixed(4))                   # extension method that adds a new .to_Decimal to the Number class

    c = a + b                                                                 # addition that will cause the prob
    c.assert_Is 0.6000000000000001                                            # confirming the problem
    c.to_Decimal().assert_Is 0.6                                              # confirming that .to_Decimal() works as expected
    c.to_Decimal().assert_Is 0.60
    c.to_Decimal().assert_Is 0.6000000

    (typeof c.to_Decimal()             ).assert_Is 'number'                   # check the value type name
    (typeof c.to_Decimal().to_Decimal()).assert_Is 'number'                   # make sure there are no side effects with multiple transformations
    c.to_Decimal().to_Decimal().assert_Is 0.6

    d = c.to_Decimal()
    (d + 0.3)             .assert_Is 0.8999999999999999                       # confirm that we have the same prob if we do another addition
    (d + 0.3).to_Decimal().assert_Is 0.9                                      # confirm we can use .to_Decimal to fix it