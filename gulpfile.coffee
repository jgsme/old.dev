gulp = require 'gulp'
mark = require 'gulp-markdown'

gulp.task 'article', ->
  gulp.src 'posts/*.md'
    .pipe mark()
    .pipe gulp.dest('build')
