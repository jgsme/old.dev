gulp = require 'gulp'
mark = require 'gulp-markdown'
jade = require 'gulp-jade-template'
article = require 'gulp-article'
publish = require 'gulp-article-publish'
fs = require 'fs'
_ = require 'lodash'
rename = require 'gulp-rename'
styl = require 'gulp-stylus'
connect = require 'gulp-connect'

paths =
  posts: 'posts/*.md'
  styl: 'src/*.styl'
  dest: 'build'

gulp.task 'article', ->
  gulp.src paths.posts
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe article()
    .pipe publish(paths.dest)

gulp.task 'index', -> fs.readdir 'posts', (err, files)->
  gulp.src "posts/#{_.last(files)}"
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe rename('index.html')
    .pipe gulp.dest(paths.dest)

gulp.task 'CNAME', -> gulp.src('src/CNAME').pipe gulp.dest(paths.dest)
gulp.task 'gfm', -> gulp.src('github-markdown-css/github-markdown.css').pipe gulp.dest(paths.dest)
gulp.task 'stylus', ->
  gulp.src paths.styl
    .pipe styl
      compress: true
    .pipe gulp.dest(paths.dest)

gulp.task 'default', ['article', 'index', 'CNAME', 'gfm', 'stylus']
gulp.task 'watch', ->
  gulp.watch paths.posts, ['article', 'index']
  gulp.watch paths.styl, ['stylus']
  connect.server
    root: paths.dest
