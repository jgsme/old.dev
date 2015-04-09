require! {
  fs
  gulp
  lodash: _
  \gulp-markdown : mark
  \./helper/article
  \./helper/articles
  \gulp-jade-template : jade
  \gulp-rename : rename
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src _.last articles!
    .pipe mark!
    .pipe article!
    .pipe jade \src/page.jade
    .pipe rename \index.html
    .pipe gulp.dest paths.dest
