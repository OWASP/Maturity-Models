module.exports = (wallaby)->
  #console.log wallaby

  just_Load = (file)->
    return { pattern: file, instrument: false, load: true, ignore: false }
  config =
    files : [      
      just_Load 'bower_components/angular/angular.js'
      just_Load 'bower_components/angular-mocks/angular-mocks.js'
      './angular/src/**/*.coffee'
    ]
    tests : [
      './angular/test/**/*.coffee'
    ]

  testFramework: 'mocha'

  return config