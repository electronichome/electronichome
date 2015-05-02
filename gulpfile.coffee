# Dependencies
gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
gss = require 'gulp-gss'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'
ghPages = require 'gulp-gh-pages'
browserSync = require 'browser-sync'

# Helpers
reportChange = (event) ->
  console.log 'File ' + event.path + ' was ' + event.type + ', running tasks...'

# Build
gulp.task 'build', ['build-images', 'build-js', 'build-css', 'build-stylus', 'build-coffee', 'build-gss', 'build-jade']

gulp.task 'build-js', ->
  gulp.src './src/assets/scripts/js/**'
    .pipe gulp.dest './dist'

gulp.task 'build-images', ->
  gulp.src './src/assets/images/**'
    .pipe gulp.dest './dist/images'

gulp.task 'build-css', ->
 gulp.src './src/assets/styles/*.css'
   .pipe gulp.dest './dist/styles'

gulp.task 'build-stylus', ->
  gulp.src './src/assets/styles/*.styl'
    .pipe stylus()
    .pipe gulp.dest './dist/styles'

gulp.task 'build-coffee', ->
  gulp.src './src/assets/scripts/coffee/**'
    .pipe coffee bare: true
      .on 'error', gutil.log
    .pipe gulp.dest './dist'

gulp.task 'build-gss', ->
  gulp.src './src/**/*.gss'
    .pipe gss()
    .pipe concat 'gss.json'
    .pipe gulp.dest './dist'

gulp.task 'build-jade', ->
  gulp.src './src/**/*.jade'
    .pipe jade pretty: true, locals: { web: true }
    .pipe gulp.dest './dist'

# Watch
gulp.task 'watch', ['build'], ->
  gulp.watch './src/**', ['build']

# Serve
gulp.task 'serve', ['build'], (done) ->
  browserSync
    open: false
    port: 9000
    server:
      baseDir: ['./dist']
      middleware:
        (request, response, next) ->
          response.setHeader 'Access-Control-Allow-Origin', '*'
          next()
  , done

  gulp.watch './src/**', ['build', browserSync.reload]
    .on 'change', reportChange

# Deploy
gulp.task 'deploy', ->
  gulp.src './dist/**'
    .pipe ghPages
      branch: 'master'
