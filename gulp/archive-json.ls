require! {
  gulp
  \./helper/archive
  \../gulpfile : {paths}
}

module.exports = ->
  gulp.src paths.posts,
    read: false
  .pipe archive "#{paths.dest}/archives"
