gulp = require 'gulp'
mark = require 'gulp-markdown'
jade = require 'gulp-jade-template'
through = require 'through2'

parse = -> through.obj (file, encoding, callback)->
  html = file.contents.toString()
  filename = /(\d{4})-(\d{2})-(\d{2})-(.*)\.html/.exec file.path
  res =
    article: html
    date:
      year: filename[0]
      month: filename[1]
      day: filename[2]
    url: filename[3]
  file.contents = new Buffer JSON.stringify res
  callback null, file

gulp.task 'article', ->
  gulp.src 'posts/*.md'
    .pipe mark()
    .pipe parse()
    .pipe jade('src/page.jade')
    .pipe gulp.dest('build')

gulp.task 'default', ['article']
