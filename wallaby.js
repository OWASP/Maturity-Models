require('fluentnode')

module.exports = function () {
    return {
        files: [
            'src/**/*.coffee',
            'views/**/*.pug', 
            { pattern: 'data/**/*', instrument: false, load: false, ignore: false },
        ],

        tests: [
            'test/**/*.coffee',
            'test/*.coffee'
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