gulp = require 'gulp'
mark = require 'gulp-markdown'
jade = require 'gulp-jade-template'
article = require 'gulp-article'
publish = require 'gulp-article-publish'
fs = require 'fs'
_ = require 'lodash'
rename = require 'gulp-rename'

gulp.task 'article', ->
  gulp.src 'posts/*.md'
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe article()
    .pipe publish('build')

gulp.task 'index', -> fs.readdir 'posts', (err, files)->
  gulp.src "posts/#{_.last(files)}"
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe rename('index.html')
    .pipe gulp.dest('build')

gulp.task 'default', ['article']
