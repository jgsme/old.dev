if location.pathname isnt '/'
  title = document.querySelector('article h1 a').textContent
  document.querySelector('title').textContent = "#{title} - Kaihatsu"

hljs.initHighlightingOnLoad()
