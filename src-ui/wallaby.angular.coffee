module.exports = (wallaby)->
  #console.log wallaby

  just_Load = (file)->
    return { pattern: file, instrument: false, load: true, ignore: false }
  config =
    files : [
      just_Load 'bower_components/angular/angular.js'
      just_Load 'bower_components/angular-route/angular-route.js'
      just_Load 'bower_components/angular-mocks/angular-mocks.js'
      # weird bug where chai will load from node_modules but not from bower_components
      #{pattern: 'bower_components/chai/chai.js', instrument: true},
      just_Load  'node_modules/chai/chai.js'
        
      './src-ui/src/**/*.coffee'
      './src-ui/.dist/js/templates.js'

    ]
    tests : [
      './src-ui/test/**/*.coffee'
    ]

    bootstrap:  ()->
      window.expect = chai.expect;

  testFramework: 'mocha'

  return config