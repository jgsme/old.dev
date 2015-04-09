require! {
  gulp
  \gulp-markdown : mark
  \./helper/article
  \gulp-jade-template : jade
  \gulp-article-publish : publish
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src paths.posts
    .pipe mark!
    .pipe article!
    .pipe jade \src/page.jade
    .pipe article!
    .pipe publish paths.dest
