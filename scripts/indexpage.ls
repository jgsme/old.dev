require! {
  fs
  glob
  \./utils.ls : {meta, md, gen}
}

out = (article)->
  fs.writeFileSync "./build/index.html", article.html.replace /<title>(.*)<\/title>/, '<title>Kaihatsu</title>'

glob \./posts/**/*.md, (err, files)->
  if err? then console.log err else files[files.length - 1] |> meta |> md |> gen |> out
