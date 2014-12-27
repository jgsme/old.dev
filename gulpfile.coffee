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
  run 'archive-json', 'archive-all', 'archive-head', callback

gulp.task 'archive-json', (done)-> fs.readdir 'posts', (err, posts)->
  posts = posts.reverse()
  allArchive = for i in [0..(posts.length / 20)] then posts.slice (i*20), (((i+1)*20)-1)
  yearlyArchive = _.groupBy posts, (post)-> /^(\d{4})/.exec(post)[1]
  monthlyArchive = _.groupBy posts, (post)-> /^(\d{4}-\d{2})/.exec(post)[1]
  allArchive = allArchive.map (data, index)-> {index: index, data: data, isHead: false, isLast: false, type: 'all'}
  allArchive[0].isLast = allArchive[allArchive.length-1].isHead = true

  mkdir.sync "#{paths.dest}/archives"
  mkdir.sync "#{paths.dest}/archives-yearly"
  mkdir.sync "#{paths.dest}/archives-monthly"

  async.parallel [
    (callback)->
      async.each allArchive,
        (archive, cb)->
          async.map archive.data, (filename, c)->
            fs.readFile "posts/#{filename}", (err, file)->
              url = /^(\d{4})-(\d{2})-(\d{2})-(.*)\.md/.exec filename
              res =
                filename: filename
                url: "/#{url[1]}/#{url[2]}/#{url[3]}/#{url[4]}.html"
                title: /^# \[(.*)\]/.exec(file.toString().split('\n')[0])[1]
              c err, res
          , (err, data)->
            archive.data = data
            fs.writeFile "#{paths.dest}/archives/#{archive.index}.json", JSON.stringify(archive), (err)-> if err? then cb err else cb null
      , (err)-> callback err
    (callback)->
      async.each _.keys(yearlyArchive),
        (key, cb)-> fs.writeFile "#{paths.dest}/archives-yearly/#{key}.json", JSON.stringify(yearlyArchive[key]), (err)-> if err? then cb err else cb null
      , (err)-> callback err
    (callback)->
      async.each _.keys(monthlyArchive),
        (key, cb)-> fs.writeFile "#{paths.dest}/archives-monthly/#{key}.json", JSON.stringify(monthlyArchive[key]), (err)-> if err? then cb err else cb null
      , (err)-> callback err
  ], (err)-> done err

gulp.task 'archive-all', ->
  gulp.src "#{paths.dest}/archives/*.json"
    .pipe jade('src/archive.jade')
    .pipe rename
      extname: '.html'
    .pipe gulp.dest("#{paths.dest}/archives")

gulp.task 'archive-head', ->
  fs.readdir "#{paths.dest}/archives", (err, files)->
    files = _.filter files, (file)-> /^\d*\.html$/.test file
    gulp.src "#{paths.dest}/archives/#{_.head(files)}"
      .pipe rename('index.html')
      .pipe gulp.dest("#{paths.dest}/archives")

gulp.task 'default', ['article', 'index', 'archive', 'CNAME', 'gfm', 'stylus']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.posts, ['article', 'index']
  gulp.watch paths.styl, ['stylus']
  connect.server
    root: paths.dest
