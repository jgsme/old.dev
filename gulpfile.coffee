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
mkdir = require 'mkdirp'
async = require 'async'
run = require 'run-sequence'
archive = require 'gulp-article-archive'
rss = require 'gulp-article-rss'
deploy = require 'gulp-gh-pages'

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

gulp.task 'archive', (callback)->
  run 'archive-json', 'archive-page', 'archive-head', callback

gulp.task 'archive-json', ->
  gulp.src 'posts',
    read: false
  .pipe archive("#{paths.dest}/archives")

gulp.task 'archive-page', ->
  gulp.src "#{paths.dest}/archives/*.json"
    .pipe jade('src/archive.jade')
    .pipe rename
      extname: '.html'
    .pipe gulp.dest("#{paths.dest}/archives")

gulp.task 'archive-head', ->
  fs.readdir "#{paths.dest}/archives", (err, files)->
    files = _.filter files, (file)-> /^page-\d*\.html$/.test file
    gulp.src "#{paths.dest}/archives/#{_.head(files)}"
      .pipe rename('index.html')
      .pipe gulp.dest("#{paths.dest}/archives")

gulp.task 'rss', ->
  gulp.src 'posts/*.md'
    .pipe rss
      title: 'kaihatsu'
      description: 'development log'
      link: 'http://dev.jgs.me'
      image: 'http://dev.jgs.me/icon.png'
      copyright: 'MIT'
      updated: new Date()
      author:
        name: 'jigsaw'
        link: 'http://jgs.me'
    .pipe gulp.dest("#{paths.dest}/feed.xml")

gulp.task 'default', ['article', 'index', 'archive', 'rss', 'CNAME', 'gfm', 'stylus']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.posts, ['article', 'index']
  gulp.watch paths.styl, ['stylus']
  connect.server
    root: paths.dest

gulp.task 'deploy', ['default'], ->
  gulp.src './build/**/*'
    .pipe deploy
      cacheDir: 'tmp'
