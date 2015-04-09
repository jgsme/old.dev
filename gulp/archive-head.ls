require! {
  gulp
  fs: {readdir}
  lodash: _
  \gulp-rename : rename
  \../gulpfile : {paths}
}

module.exports = -> readdir "#{paths.dest}/archives", (err, files)->
  files = _.filter files, (file)-> /^page-\d*\.html$/.test file
  gulp.src "#{paths.dest}/archives/#{_.head(files)}"
    .pipe rename \index.html
    .pipe gulp.dest "#{paths.dest}/archives"
