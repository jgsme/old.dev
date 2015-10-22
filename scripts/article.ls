require! {
  fs
  mkdirp
  glob
  \./utils.ls : {meta, md, gen}
}

err, files <- glob \./posts/**/*.md

if err?
  console.log err
  process.exit 1

files
  .map meta
  .map md
  .map gen
  .forEach (article)->
    dir = "./build/#{article.date.year}/#{article.date.month}/#{article.date.day}"
    mkdirp.sync dir
    fs.writeFileSync "#{dir}/#{article.filename}.html", article.html
