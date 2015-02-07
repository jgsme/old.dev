fs = require 'fs'
gulp = require 'gulp'
_ = require 'lodash'
mark = require 'gulp-markdown'
article = require './helper/article'
jade = require 'gulp-jade-template'
rename = require 'gulp-rename'
{paths} = require '../gulpfile'

module.exports = ->
  years = fs.readdirSync 'posts'
  year = _.last years
  months = fs.readdirSync "posts/#{year}"
  month = _.last months
  days = fs.readdirSync "posts/#{year}/#{month}"
  day = _.last days
  mds = fs.readdirSync "posts/#{year}/#{month}/#{day}"
  md = _.last mds
  gulp.src "posts/#{year}/#{month}/#{day}/#{md}"
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe rename('index.html')
    .pipe gulp.dest(paths.dest)
