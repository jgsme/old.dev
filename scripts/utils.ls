require! {
  fs
  \markdown-it : MarkdownIt
  jade
  mkdirp
}

md = new MarkdownIt do
  html: true
  linkify: true

exports.meta = (file)->
  r = /(\d{4})\/(\d{2})\/(\d{2})\/(.*)\.md$/.exec file
  body = fs.readFileSync file
           .toString!
           .split \\n

  filepath: file
  body: null
  html: null
  date:
    year: r.1
    month: r.2
    day: r.3
  filename: r.4
  url: file.replace /^\.\/posts/, ' '
           .replace /md$/, \html
  title: /^# \[(.*)\]/.exec(body[0])[1]
  description: body.slice 2, 5
                   .join \\n

exports.md = (article)->
  article
    ..body = fs.readFileSync article.filepath
               .toString!
               |> md.render

exports.gen = (article)->
  article
    ..html = jade.compileFile \./src/page.jade <| article
