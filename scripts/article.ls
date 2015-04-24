require! {
  fs
  glob
  marked
  jade
  mkdirp
}

meta = (file)->
  r = /(\d{4})\/(\d{2})\/(\d{2})\/(.*)\.md$/.exec file
  filepath: file
  body: null
  html: null
  date:
    year: r[1]
    month: r[2]
    day: r[3]
  filename: r[4]
  url: file.replace /^\.\/posts/, ' ' .replace /md$/, \html

md = (article)->
  article.body = fs.readFileSync article.filepath .toString! |> marked
  article

gen = (article)->
  article.html = jade.compileFile \./src/page.jade <| article
  article

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
