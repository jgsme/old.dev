gulp = require 'gulp'
mark = require 'gulp-markdown'
jade = require 'gulp-jade-template'
article = require 'gulp-article'
publish = require 'gulp-article-publish'

gulp.task 'article', ->
  gulp.src 'posts/*.md'
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe article()
    .pipe publish('build')

gulp.task 'default', ['article']
