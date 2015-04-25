# Gulp File

gulp = require('gulp')
ghPages = require('gulp-gh-pages')
gulp.task 'deploy', ->
  gulp.src('./dist/**/*').pipe ghPages()


gulp.task 'build', ->
  gulp.src('./src/**/*').pipe gulp.dest('./')
