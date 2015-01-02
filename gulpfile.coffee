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
coffee = require 'gulp-coffee'

paths =
  posts: 'posts/*.md'
  styl: 'src/*.styl'
  dest: 'build'
  coffee: 'src/*.coffee'

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

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
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

gulp.task 'archive-head', -> fs.readdir "#{paths.dest}/archives", (err, files)->
  files = _.filter files, (file)-> /^page-\d*\.html$/.test file
  gulp.src "#{paths.dest}/archives/#{_.head(files)}"
    .pipe rename('index.html')
    .pipe gulp.dest("#{paths.dest}/archives")

gulp.task 'rss', -> fs.readdir 'posts', (err, files)->
  files = _.map files.slice(-20), (file)-> "posts/#{file}"
  gulp.src files.reverse()
    .pipe rss
      title: 'kaihatsu'
      description: 'development log'
      feed_url: 'http://dev.jgs.me/feed.xml'
      site_url: 'http://dev.jgs.me'
      image_url: 'http://dev.jgs.me/icon.png'
      author: 'jigsaw'
      copyright: '(c) 2015 jigsaw'
      updated: new Date()
    .pipe gulp.dest("#{paths.dest}/feed.xml")

gulp.task 'default', ['article', 'index', 'archive', 'rss', 'CNAME', 'gfm', 'stylus', 'coffee']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.posts, ['article', 'index']
  gulp.watch paths.styl, ['stylus']
  connect.server
    root: paths.dest

gulp.task 'deploy', ['default'], ->
  gulp.src './build/**/*'
    .pipe deploy
      cacheDir: 'tmp'
