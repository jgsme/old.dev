require! {
  fs
  mkdirp
  glob
  lodash: _
  jade
  \./utils.ls : {meta}
}

out = (template, data)->
  mkdirp.sync \./build/archives
  data.forEach (d)->
    html = jade.compileFile template <| d
    fs.writeFileSync "./build/archives/#{d.filename}.html", html

generate = (files)->
  articles = files.map meta
  yearly = _.groupBy articles, (article)-> article.date.year
  monthly = _.groupBy articles, (article)-> "#{article.date.year}-#{article.date.month}"
  pagely = for i in [0 to articles.length / 20] then articles.reverse!.slice i * 20, ((i + 1) * 20) - 1

  out do
    \./src/archive-yearly.jade
    Object.keys yearly .map (year)->
      year: year
      articles: yearly[year]
      filename: year

  out do
    \./src/archive-monthly.jade
    Object.keys monthly .map (key)->
      skey = key.split \-
      year: skey[0]
      month: skey[1]
      articles: monthly[key]
      filename: key

  out do
    \./src/archive-pagely.jade
    Object.keys pagely .map (key)->
      nkey = parseInt key
      index: nkey
      articles: pagely[key]
      filename: if key is '0' then \index else "page-#{key}"
      prevlink: if pagely[(nkey + 1).toString!]? then "/archives/page-#{nkey + 1}.html" else null
      nextlink: if nkey is 0 then null else if nkey is 1 then \/archives/index.html else "/archives/page-#{nkey - 1}.html"

glob \./posts/**/*.md, (err, files)->
  if err? then console.log err else generate files
