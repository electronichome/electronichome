# Gulp File

gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
jade = require 'gulp-jade'
ghPages = require('gulp-gh-pages')
gulp.task 'deploy', ->
  gulp.src('./dist/**/*').pipe ghPages()


gulp.task 'build', ->
  gulp.src('./src/**/*.html').pipe gulp.dest('./')

  gulp.src './src/**/*.jade'
    .pipe jade pretty: true, locals: { web: true }
    .pipe gulp.dest './'

  gulp.src('./src/**/*.coffee')
    .pipe coffee bare: true
      .on 'error', gutil.log
    .pipe gulp.dest('./')


