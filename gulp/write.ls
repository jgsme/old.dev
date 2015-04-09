require! {
  gulp
  inquirer
  \gulp-data : data
  through2: through
  mkdirp: mkdir
}

transform = (file, encoding, callback)-> inquirer.prompt do
  [
    * type: 'input'
      name: 'title'
      message: 'title'
    * type: 'input'
      name: 'url'
      message: 'url'
  ]
  (answers)->
    {title, url} = answers

    today = new Date!
    year = today.getFullYear!
    month = today.getMonth! + 1
    day = today.getDate!
    if month.toString!.length is 1 then month = "0#{month}"
    if day.toString!.length is 1 then day = "0#{day}"

    mkdir.sync "#{file.base}#{year}/#{month}/#{day}"

    file.path = "#{file.base}#{year}/#{month}/#{day}/#{url}.md"
    file.contents = new Buffer "# [#{title}](/#{year}/#{month}/#{day}/#{url}.html)"

    callback null, file

module.exports = ->
  gulp.src '',
    read: false
  .pipe through.obj transform
  .pipe gulp.dest \posts
