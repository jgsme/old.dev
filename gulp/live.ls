require! {
  gulp
  \gulp-livescript : lsc
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src paths.ls
    .pipe lsc!
    .pipe gulp.dest paths.dest
