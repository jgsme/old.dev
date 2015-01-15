gulp = require 'gulp'
archive = require 'gulp-article-archive'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src 'posts',
    read: false
  .pipe archive("#{paths.dest}/archives")
