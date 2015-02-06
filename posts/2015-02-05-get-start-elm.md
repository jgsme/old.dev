# [Elm に本腰を入れてみようと](/2015/02/05/get-start-elm.html)

http://elm-lang.org/

次世代 JavaScript フレームワークが百花繚乱で戦国時代な今、自分が求めているのは Elm なんじゃないかとおもってきて環境つくるところからやった。

## install

cabal でやるか pkg からインストールするか迷ったが、最終的に brew cask にした

```
% brew cask install elm-platform
```

## evancz/elm-examples

ひとまず [evancz/elm-examples](https://github.com/evancz/elm-examples) を clone して試した。

```
% cd elm-examples
% elm-reactor
Elm Reactor 0.3
Listening on http://0.0.0.0:8000/
```

この `elm-reactor` がスゴくて、起動すると

![](https://cloud.githubusercontent.com/assets/557961/6058446/ddbf634c-ad6a-11e4-9927-eae713949500.png)

というようなページが立ち上がって `Hello.elm` をクリックするとコンパイルされた実行結果のページが表示される。さらにすごいのが、Elm には Time Traveling Debugger っていう機能があって (http://debug.elm-lang.org/edit/Stamps.elm) Time Traveling の名の通り入力を巻き戻したりできるのだ。スパナのアイコンを押すとこのデバッガが立ち上がってデバッグできる。すごい。

## Atom 環境

https://github.com/edubkendo/atom-elm を入れればシンタックスハイライト効くしだいたいオッケー。WebStorm にもプラグインがあるようなのでいずれ試す。

## Syntax Reference

基本的に http://elm-lang.org/learn/Syntax.elm あたりを見ればオッケー。

Example の `Hello.elm` には

```elm
main : Element
main =
    flow down
      [ helloWorld
      , welcomeGraphics
      ]
```

というような `flow` という構文?関数?があってなんじゃらホイとなったが、 http://elm-lang.org/edit/examples/Elements/FlowDown1a.elm を見てあっさりわかった。

```elm

{-------------------------------------------------------------
  Elements can be combined into more complex layouts using
  the flow function:

         flow : Direction -> [Element] -> Element

  It is easy to change the direction of flow. Just use a
  different value for the direction!

     down, up, left, right, inward, outward : Direction

  Try switching "down" in the code below with "up".
-------------------------------------------------------------}

import Graphics.Element (..)
import Text (..)


main : Element
main =
  flow right
    [ plainText "By using the \"flow\" function,"
    , plainText "we can stack elements"
    , plainText "on top of other elements."
    ]
```

`flow` の定義は `flow : Direction -> [Element] -> Element` で、`Direction` (`down, up, left, right, inward, outward : Direction`) と `[Element]` から `Element` をつくる関数のようだ。なので `up` とすると

```
on top of other elements.
we can stack elements
By using the "flow" function,
```

になるし `right` にすると

```
By using the "flow" function,we can stack elementson top of other elements.
```

横に連結するような定義になっているようだ。実際に生成される html を見てみると `right` とか `left` をつけると inline style で `float left` とか `float right` が勝手に設定されて意図したデザインとなる。ここだけ取ってみても従来の HTML + CSS + JavaScript の構成でドキュメント構造考えて...スタイル考えて...スクリプト書いて...というようなはっきり言ってめんどくさいことをやらずに済むことが分かる。

とりあえず今日はこの辺で。
