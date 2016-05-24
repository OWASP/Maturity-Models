return 
Spectron_API = require '../src/Spectron-API'

describe 'constructor',->
    it 'constructor', ->
      using new Spectron_API(), ->
        @.Application.assert_Is_Function()
        assert_Is_Null @.app
        
    it 'default_App_Path', ->
      using new Spectron_API(), ->
        @.default_App_Path().assert_Folder_Exists().assert_Contains '/electron-apps/web-view'
                            .files().file_Names()  .assert_Contains ['index.html', 'main.js', 'package.json', 'web-view.html']
                                  
    it 'setup', ->
      using new Spectron_API(), ->
        @.setup().assert_Is @
        app_Path = @.default_App_Path()
        using @.app, ->
          @.host                .assert_Is '127.0.0.1'
          @.port                .assert_Is 9515
          @.quitTimeout         .assert_Is 1000
          @.startTimeout        .assert_Is 5000
          @.waitTimeout         .assert_Is 5000
          @.connectionRetryCount.assert_Is 10
          @.nodePath            .assert_Is process.execPath
          @.args                .assert_Is []
          @.env                 .assert_Is {}
          @.workingDirectory    .assert_Is __dirname.path_Combine('../..')
          @.path()              .assert_Is app_Path
          @.api.app             .assert_Is @
          @.api.requireName     .assert_Is 'require'
          @.transferPromiseness .assert_Is_Function()

    #@.timeout 5000
    xit 'start and stop', (done)->
      using new Spectron_API().setup(), ->
          @.start().then ->
          #@.start().then ->
            console.log 'asd'
            done()

        