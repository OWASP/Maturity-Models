gulp          = require 'gulp'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
pug           = require 'gulp-pug'
plumber       = require 'gulp-plumber'
templateCache = require('gulp-angular-templatecache');


source_Folder = './src/**/*.coffee'
pug_Folder    = './views/**/*.pug'
html_Folder   = './.dist/html'
js_Folder     = './.dist/js'

gulp.task 'compile-pug', ()->
  gulp.src pug_Folder
      .pipe plumber()
      .pipe pug()
      .pipe gulp.dest html_Folder

gulp.task 'compile-coffee', ()->
  gulp.src(source_Folder)
    .pipe plumber()
    .pipe coffee {bare: true}
    .pipe concat js_Folder + '/angular-src.js'
    .pipe gulp.dest '.'

gulp.task 'templateCache', ['compile-pug'], ()->
  gulp.src html_Folder + '/**/*.html'
      .pipe templateCache( module: 'MM_Graph' )
      .pipe gulp.dest js_Folder

gulp.task 'watch', ['compile-coffee', 'compile-pug', 'templateCache'], ()->
  gulp.watch source_Folder, ['compile-coffee']
  gulp.watch pug_Folder, ['compile-pug', 'templateCache']

gulp.task 'default', ['compile-coffee','compile-pug'], ()->
