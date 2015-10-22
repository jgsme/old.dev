require! {
  fs
  glob
  \./utils.ls : {meta, md, gen}
}

err, files <- glob \./posts/**/*.md

if err?
  console.log err
  process.exit 1

files[*-1]
  |> meta
  |> md
  |> gen
  |> (article)->
    fs.writeFileSync do
      "./build/index.html"
      article.html.replace /<title>(.*)<\/title>/, '<title>Kaihatsu</title>'
