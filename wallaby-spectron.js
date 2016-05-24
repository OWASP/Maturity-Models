module.exports = function (wallaby) {
    wallaby
    return {
        files: [
            { pattern: 'test-spectron/src/**/*.coffee'},
            { pattern: 'test-spectron/electron-apps/**/*.*', instrument: false},
        ],

        tests: [
            'test-spectron/test/**/*.coffee'
        ],

        //testFramework: 'mocha',

        env: {
            type: 'node'//,
        },
    };
};