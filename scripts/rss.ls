require! {
  fs
  glob
  rss: RSS
  \./utils.ls : {meta}
}

err, files <- glob \./posts/**/*.md, (err, files)->

if err?
  console.log err
  process.exit 1

files
  .slice -20
  .reverse!
  .map meta
  .reduce do
    (rss, article)->
      rss
        ..item do
          title: article.title
          description: article.description
          url: article.url
          date: new Date article.date.year, parseInt(article.date.month) - 1, article.date.day
    new RSS do
      title: \kaihatsu
      description: 'development log'
      feed_url: \http://dev.jgs.me/feed.xml
      site_url: \http://dev.jgs.me
      image_url: \http://dev.jgs.me/icon.png
      author: \jigsaw
      copyright: '(c) 2015 jigsaw'
      updated: new Date!
  |> (rss)-> fs.writeFileSync \./build/feed.xml, rss.xml!
