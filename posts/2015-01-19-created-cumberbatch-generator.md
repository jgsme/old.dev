# [cumberbatch ジェネレータをつくった](/2015/01/19/created-cumberbatch-generator.html)

http://cumberbatch.jgs.me/

Sindre さんが Github 上で dog-name とか cat-name っていうリポジトリでポピュラーなペットの名前を生成する cli を作ってたのに感化されたひとたちが dragon-name とかを作ってたんだけど、その中で一番おもしろかったのが [Trott/cumberbatch-name](https://github.com/Trott/cumberbatch-name) で、ベネディクト・カンバーバッチさんっぽい名前を生成してくれる cli である。面白かったので勢いでオンラインで生成できるやつをつくった。

https://github.com/jgsme/cumberbatch

最近ずっと React を触ってたので適当に React でつくってみた。ひとつしかコンポーネントを使ってないので微妙感あるけど、だいたいこんな感じでコンポーネント作るんだなってのは分かってきた。CoffeeScript での `React.DOM` や、inline css でスタイルシート書いたりとか。いまは、複数のコンポーネントが絡むときに state の値の受け渡しとかのうまい設計を模索してみている。
