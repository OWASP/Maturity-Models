require('fluentnode')

var helpers = require('./global-setup')


electron_Prebuild = require('electron-prebuilt')

appPath      = __dirname.path_Combine('../../electron-apps/web-view')

var Application = require('spectron').Application
var assert = require('assert')

describe('application launch 3', function () {
    this.timeout(10000)
    var app = null
    var path = [appPath]

    beforeEach(function (done) {
        helpers.setupTimeout(this)
        return helpers.startApplication({
            args: path
                    }).then(function (startedApp) { app = startedApp; done()  })
    })

    afterEach(function () {
        return helpers.stopApplication(app)
    })

    afterEach(function () {
        //if (this.app && this.app.isRunning()) {
        //    return this.app.stop()
        //}
    })

    it('shows an initial window abc', function () {
        app.isRunning().assert_Is_True()
        return app.client.getWindowCount().then(function (count) {
            assert.equal(count, 2)
        })
    })
})