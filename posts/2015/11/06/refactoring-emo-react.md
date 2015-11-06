# [emo-react をリファクタした](/2015/11/06/refactoring-emo-react.html)

https://github.com/e-jigsaw/emo-react/pull/4

しばらく触らぬ間に React がアップデートしてたり、Redux が flux のデファクトっぽくなってたりしたので学習も兼ねてアップグレードした。細々気付いたこととか。

## React `0.14` 所感

`0.13` から細々変わっていて、react に元々いたメソッドが `react-dom` に移ったりしていて

* `render` は単純に移った
* `@refs.something.getDOMNode!...` としていたところが `findDOMNode @refs.something` のような感じになっていた

あたりで躓いたが、react は懇切丁寧にエラーを投げてくれるので対処も容易であった。ちなみに、このリポジトリ自体は `0.12` の頃に作っていたので `React.Component` などもない前提で作っていたが、`0.13` を他で触っていたので特にこのあたりは困らなかった。

## Redux 所感

群雄割拠していた flux ライブラリも雰囲気 redux に落ち着いてきてるような感覚でいるのだけれど、どうなんだろう。redux は root の要素の state を store として、それに対してアクションを発行して更新していく〜というような概要ぐらいしか知らなかったのだが実際にアプリケーションを組んでいくと、各所に散らばっていた state <-> prop のごちゃごちゃを action と reducer に統合してアプリケーションの状態というものをこれによって表現できるというあたりが良さなんだと感じた。

最初は分からなかったが、reducers の key が root の要素の prop になるので、root の、ひいては root 下のコンポーネントで必要な情報とは何かというのを整理していけば自然と reducers が出来上がっていく。あとはこのオブジェクトを redux の `combine-reducers` に食わしてやれば OK。

reducers を作っていくのと平行して、reducers を更新する行動を整理していくのが actions を作っていくことのように感じた。reducers と actions は共にただの関数だったり、オブジェクトだったりするのでそこを意識して素直に書けばよかった。

ハマったのは、reducer A が更新されたら reducer B も更新されてほしい、というようなとき。最初は単一の reducer にして state のプロパティを更新するだけ、というような方式にしていたのだが、これだとどうしても `Object.assign` が必要で、Polyfill をいれるにもダルいし、あんまり綺麗じゃないなーとおもって四苦八苦した。最終的に分かったのは、`redux-thunk` という middleware を使うと action で `(dispatch, get-state)` を引数にとる関数を定義することができるので、`get-state` から必要になる情報を引き出して適切なアクションを `dispatch` してやればいい、ということだった。

また、非同期処理を含む action に関しても同様で上記のような関数を定義して非同期処理の Promise でも callback でも適当なところでアクションを `dispatch` すればいいようだった。

ただ、微妙な解決になってしまったのがこの `redux-thunk` を `apply-middleware` するときで、ES2015 だと `applyMiddleware(middleware)(reducers)` というようなインターフェイスで ls からは少し書きづらかった。(別にそこを求めたいわけではないが...)

最終的に

```livescript
apply-middleware thunk-middleware |> (.call @, create-store) |> (.call @, reducers)
```

みたいな、pipe と assign short-hand を使って `call` することにした。。。冷静に考えると普通に括弧使って書いた方が簡潔な気がする。。。あと `connect` も 関数をとって関数を返すような実装になっているので

```livescript
  connect do
    (state)-> state
  <| App
```

のような感じで書かないとダメだった。

## Node.js v5.0.0

npm@3 使ってみたさ故に v5.0.0 で開発してみたが、特に困ることはなかった。ウワサ通り `node_modules` は猛烈に flat になったし、インストールや run-script の実行なんかでもプログレスバーがアニメーションするようになったりして気持ちよかった。Docker Hub にもリリースされているので、Wercker でこれを使ってビルドしたがこちらも遜色なく。

## その他

使っている PureCSS をアップデートしたり、gulp から npm-run-all に切り替えたり、aja を isomorphic-fetch に換えたりした。
