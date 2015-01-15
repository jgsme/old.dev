fs = require 'fs'
gulp = require 'gulp'
_ = require 'lodash'
mark = require 'gulp-markdown'
article = require 'gulp-article'
jade = require 'gulp-jade-template'
rename = require 'gulp-rename'
{paths} = require '../gulpfile'

module.exports = -> fs.readdir 'posts', (err, files)->
  gulp.src "posts/#{_.last(files)}"
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe rename('index.html')
    .pipe gulp.dest(paths.dest)
