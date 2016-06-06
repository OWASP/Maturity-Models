gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
pug         = require 'gulp-pug'
plumber     = require 'gulp-plumber'

source_Folder = './src/**/*.coffee'
pug_Folder    = './views/*.pug'

gulp.task 'compile-pug', ()->
  gulp.src pug_Folder
      .pipe plumber()
      .pipe pug()
      .pipe gulp.dest './.dist/html'

gulp.task 'compile-coffee', ()->
  gulp.src(source_Folder)
    .pipe plumber()
    .pipe coffee {bare: true}
    .pipe concat './.dist/js/angular-src.js'
    .pipe gulp.dest '.'


gulp.task 'watch', ['compile-coffee', 'compile-pug'], ()->
  gulp.watch source_Folder, ['compile-coffee']
  gulp.watch pug_Folder, ['compile-pug']

gulp.task 'default', ['compile-coffee','compile-pug'], ()->
