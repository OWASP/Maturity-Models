'use strict';

var wallabyWebpack = require('wallaby-webpack');
var webpackPostprocessor = wallabyWebpack({});


module.exports = function (wallaby) {
    //var preload_File = wallaby.localProjectDir + 'preload.js'
    return {
        files: [
            { pattern: 'src/**/*.js', load: false }
        ],

        tests: [
            { pattern: 'test/**/*Spec.js', load: false },
            { pattern: 'test/**/*.coffee', load: false }
        ],

        env: {
            kind: 'electron',
            options: {
                show: false,
                skipTaskbar: false,
                autoHideMenuBar: false,
                webPreferences: {
                    nodeIntegration: false,
                    webSecurity: false,
                }
            }},

        compilers: {
            '**/*.coffee': wallaby.compilers.coffeeScript({})
        },

        testFramework: 'mocha',
        postprocessor: webpackPostprocessor,

        bootstrap: function () {
            window.__moduleBundler.loadTests();

        }
    };
};


/*
module.exports = function (wallaby) {

        console.log(wallaby)
        process.env.NODE_PATH = require('path').join(wallaby.localProjectDir, '../node_modules');

        return {
        files: [
            'src/** /*.coffee',
        ],

        tests: [
            '** /*.coffee'
        ],

        env: {
            type: 'node'
        }
    };
};
*/