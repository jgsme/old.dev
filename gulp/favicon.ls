require! {
  gulp
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src \src/favicons/*
    .pipe gulp.dest paths.dest
