module.exports = function () {
    return {
        files: [
            'src/**/*.coffee',
            'views/**/*.jade',
            { pattern: 'data/**/*'              , instrument: false, load: false, ignore: false },
            { pattern: 'bower_components/**/*.*', instrument: false, load: false, ignore: false }
        ],

        tests: [
            'test/**/*.coffee'
        ],

        env: {
            type: 'node'
        }
    };
};