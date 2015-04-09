require! {
  gulp
  \gulp-jade-template : jade
  \gulp-rename : rename
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src "#{paths.dest}/archives/*.json"
    .pipe jade \src/archive.jade
    .pipe rename do
      extname: \.html
    .pipe gulp.dest "#{paths.dest}/archives"
