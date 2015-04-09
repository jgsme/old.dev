require! {
  gulp
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src \src/CNAME
    .pipe gulp.dest paths.dest
