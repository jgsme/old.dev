require! {
  fs
  marked
  jade
  mkdirp
}

exports.meta = (file)->
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

exports.md = (article)->
  article.body = fs.readFileSync article.filepath .toString! |> marked
  article

exports.gen = (article)->
  article.html = jade.compileFile \./src/page.jade <| article
  article
