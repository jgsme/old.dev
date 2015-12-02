# [fetch の今](/2015/12/02/fetch.html)

SPA 作るときに Ajax が絡むときは Github の [fetch](https://github.com/github/fetch) を使うようにしていたのだが、Browserify や Webpack でバンドルしようとするとそれが考慮されていないので死ぬ。

そこで、[isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch) を使いましょうという話だが、`require` し忘れたまま開発していたが Chrome だと fetch が既に実装されているので気付かないままだった。

モバイルの対応をするために iOS の Safari で確認してたときになぜかリクエストが発火してなかったので気付くに至った。一方、iOS8 以降であれば `Promise` は使えるようなので polyfill は使わなくてよかった。ただ、Mobile Safari だと `undefined` に文字列を食わせてるのにエラーが出なくて、気付くのが遅くなった。

```livescript
if fetch is undefined then fetch = require \fetch
```

と一行加えるだけだったんだけど、非対応ブラウザのために polyfill 載せるのもな...みたいな気分になって、動的ロードも考えたんだけど面倒だったのでバンドルすることにした。ES6 modules 早くきてくれ〜。

他方で fetch は前述の通り Chrome では(for Andoid でも)使えるし Firefox でも使えるのだが、(Mobile でない方の) Safari は使えないし Edge でも使えないのは意外だった。
