require! {
  fs: {readdirSync}
}

module.exports = ->
  res = []
  years = readdirSync \posts
  for year in years
    months = readdirSync "posts/#{year}"
    for month in months
      days = readdirSync "posts/#{year}/#{month}"
      for day in days
        articles = readdirSync "posts/#{year}/#{month}/#{day}"
        for article in articles
          res.push "posts/#{year}/#{month}/#{day}/#{article}"
  res
