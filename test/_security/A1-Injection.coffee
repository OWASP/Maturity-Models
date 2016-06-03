Data_Files = require '../../src/backend/Data-Files'

Number::random_Chars = ->
  "".add_Random_Chars(@ + 0)

# These tests represent Injections Security Issues
# See https://www.owasp.org/index.php/Top_10_2013-A1-Injection for more references
describe '_security | A1 - Injection', ->