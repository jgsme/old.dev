require! {
  gulp
  \gulp-connect : connect
  \run-sequence : run
  \gulp-gh-pages : deploy
}

exports.paths = paths =
  posts: \posts/**/*.md
  styl: \src/*.styl
  dest: \build
  ls: \src/*.ls

[
  \article
  \indexpage
  \CNAME
  \gfm
  \stylus
  \live
  \archive-json
  \archive-page
  \archive-head
  \rss
  \favicon
  \write
].forEach (name)-> gulp.task name, require "./gulp/#{name}"

gulp.task \archive, (callback)->
  run do
    \archive-json
    \archive-page
    \archive-head
    callback

gulp.task \default, [
  \article
  \indexpage
  \archive
  \rss
  \CNAME
  \gfm
  \favicon
  \stylus
  \live
]
gulp.task \watch, [\default], ->
  gulp.watch paths.posts, [\article, \index]
  gulp.watch paths.styl, [\stylus]
  connect.server do
    root: paths.dest
gulp.task \deploy, ->
  gulp.src \./build/**/*
    .pipe deploy do
      cacheDir: \tmp
