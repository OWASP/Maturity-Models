module.exports = function () {
    return {
        files: [
            'src/**/*.coffee',
            'views/**/*.jade'
        ],

        tests: [
            'test/**/*.coffee'
        ],

        env: {
            type: 'node'
        }
    };
};