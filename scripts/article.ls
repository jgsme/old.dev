require! {
  fs
  mkdirp
  glob
  \./utils.ls : {meta, md, gen}
}

out = (article)->
  dir = "./build/#{article.date.year}/#{article.date.month}/#{article.date.day}"
  mkdirp.sync dir
  fs.writeFileSync "#{dir}/#{article.filename}.html", article.html

generate = (files)->
  files
    .map meta
    .map md
    .map gen
    .forEach out

glob \./posts/**/*.md, (err, files)->
  if err? then console.log err else generate files
