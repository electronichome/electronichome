# Gulp File

gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
jade = require 'gulp-jade'
ghPages = require('gulp-gh-pages')
browser-sync = require('browser-sync')
paths = 
  

reportChange = (event) ->
  console.log 'File ' + event.path + ' was ' + event.type + ', running tasks...'
  return

gulp.task 'deploy', ->
  gulp.src('./dist/**/*')
    .pipe ghPages(
      branch: 'master'
    )

gulp.task 'build', ->
  gulp.src('./src/**/*.html').pipe gulp.dest('./dist')

  gulp.src './src/**/*.jade'
    .pipe jade pretty: true, locals: { web: true }
    .pipe gulp.dest './dist'

  gulp.src('./src/**/*.coffee')
    .pipe coffee bare: true
      .on 'error', gutil.log
    .pipe gulp.dest('./dist')

gulp.task 'watch', [ 'serve' ], ->
  gulp.watch(paths.source, [
    'build-system'
    browserSync.reload
  ]).on 'change', reportChange
  gulp.watch(paths.html, [
    'build-html'
    browserSync.reload
  ]).on 'change', reportChange
  gulp.watch(paths.style, browserSync.reload).on 'change', reportChange
  return