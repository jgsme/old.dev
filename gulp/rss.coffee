gulp = require 'gulp'
fs = require 'fs'
_ = require 'lodash'
rss = require 'gulp-article-rss'
{paths} = require '../gulpfile'

module.exports = -> fs.readdir 'posts', (err, files)->
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
