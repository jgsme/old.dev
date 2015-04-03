# [LiveScript がだいぶ馴染んできた](/2015/04/03/adjust-livescript.html)

http://livescript.net/

ES6 に押され気味な CoffeeScript をなんとかせねばという想いがあったのだが、CoffeeScript はかなり保守的で最近 generators が入ったりはしたもののゆったりした感じでなんとも気力が湧かなかった。そこで、3回目ぐらいの LiveScript に入信を果たしたところ、今回は毎週 Haskell もくもく会をやっている甲斐もあってかわかりがだいぶあった。

Coffee との違いは http://livescript.net/#coffee-to-ls を見てもらうとして、今日スッときたのが `do` 構文である。

Coffee では

```coffeescript
f
  a: x
  b: y
```

と書けば

```js
f({
  a: x,
  b: y
});
```

みたいな感じで変換されるのが、LiveScript だと

```livescript
f do
  a: x
  b: y
```

と書かなければならず、冗長だと感じていた。`do` は `do` 以降の構文を `do` 以前の関数の引数として食わせる構文。この `do` 構文がすごいのは、`Object` のあとに関数や配列など、`Object` 以外の引数をとるときである。

Coffee だと

```coffeescript
f
  a: x
  b: y
, (c)-> g c
```

というふうに書いて

```javascript
f({
  a: x,
  b: y
}, function(c) {
  g(c);
});
```

みたいな出力がされる。これが LiveScript だと

```livescript
f do
  a: x
  b: y
  (c)-> g c
```

と書くだけで上のような JS が出力できるのである！！これだけだとまだスゴさが感じられないとおもうんだけど、これが真価を発揮するのが React の `render` で `DOM` を書くときである。

Coffee だと

```coffeescript
render: ->
  DOM.div
    key: 'key'
  , [
    DOM.a
      key: 'key2'
      href: '...'
    , [
      DOM.div
        key: 'key3'
      , 'link'
    ]
  ]
```

という雰囲気で書かなくてはならないのだが、LiveScript だと

```livescript
render: ->
  DOM.div do
    key: 'key'
    [
      DOM.a do
        key: 'key2'
        href: '...'
        [
          DOM.div do
            key: 'key3'
            'link'
        ]
    ]
```

と、`,` とか `[]` のインデントを気にしたりせずに書けるのです...!スッキリ!(と感じるかは個人差があるとはおもいます)

あとは、`require!` とか `|>`, `<|` のパイプ、`\str` と書ける backslash-string など Coffee からさらに(関数脳に)気持ちいいシンタックスになってて気持ちが完全に LiveScript に持って行かれました。

あと、これずっと言いたかったんだけど ES6 勢力が「Coffee はもうオワコン！時代は ES6！！」みたいなことを声高に言ってますけど ES6 のフィーチャはほとんど Coffee にも(もちろん LiveScript にも)あるしずっと Coffee 書いてた身からしてみると、わざわざ `{}` や `;` を書くために ES6 を書くだけでしかなくて全然嬉しさがない。ES6 も ES5 に変換可能なわけだからネイティブで動くからといってあまりそっちを選択することにメリットがあることが少ないんじゃないかなーとおもってるんだけどどうだろ。

ひとまず、僕はしばらく LiveScript という安住の地に住み続けます。
