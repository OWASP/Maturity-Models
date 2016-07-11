require('fluentnode')

module.exports = function () {
    return {
        files: [
            'code/api/src/**/*.coffee',
            'code/api/views/**/*.pug',
            { pattern: 'data/**/*'        , instrument: false, load: false, ignore: false },
            { pattern: 'code/ui/src/services/*', instrument: false, load: false, ignore: false },
        ],

        tests: [
            'code/api/test/**/*.coffee',
            'code/api/test/*.coffee'
        ],

        env: {
            type: 'node'
        },
        setup: function (wallaby)
            {

            },
        workers: {
            initial: 1,         // without these sometimes the fluentnode apis
            regular: 1          // are not detected
        }
    };
};