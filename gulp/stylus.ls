require! {
  gulp
  \gulp-stylus : styl
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src paths.styl
    .pipe styl do
      compress: true
    .pipe gulp.dest paths.dest
