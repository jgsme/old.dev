# [atomのgrammarの構文がいまいちよく分からない](/2015/01/31/can-not-understand-atom-grammar-structure.html)

https://github.com/e-jigsaw/atom-jade/blob/ac7246406c9a1753cef1403ec16025150315ce68/grammars/jade.cson

Atom の language-jade で coffeescript がシンタックスハイライトされなくて困ったなあとなったのでとりあえず直してみることにしたら意外と大変だった。

```jade
some
  script(type='text/coffeescript').
    x = 100
    x.toString()
```

こういうやつ。元々 JavaScript のコードをハイライトさせるやつはあったから、それの JS になってる部分を Coffee に変えればいいや、とおもってコピペしてそれっぽく `source.coffee` に変えるとハイライトされるようにはなった。

が、

```jade
some

  script(type='text/coffeescript').
    x = 100
    x.toString()
```

みたいな感じで改行が入ると [tag.jade](https://github.com/e-jigsaw/atom-jade/blob/ac7246406c9a1753cef1403ec16025150315ce68/grammars/jade.cson#L295) と認識されてハイライトされなくなって困った。試行錯誤してみると https://github.com/e-jigsaw/atom-jade/blob/ac7246406c9a1753cef1403ec16025150315ce68/grammars/jade.cson#L927-L959 こんな感じで `repository` に追加して https://github.com/e-jigsaw/atom-jade/blob/ac7246406c9a1753cef1403ec16025150315ce68/grammars/jade.cson#L316 を付け足してやるとなんとなく動くようになったので一旦これでいくことにした。

とはいえ正規表現が雑なので

```jade
some

  script(type='text/coffeescript', data='hoge').
    x = 100
    x.toString()
```

みたいなことされると死ぬ。あと `(type='text/coffeescript')` のところがハイライトされない問題も抱えている。TextMate の構文をそのまま持ってきているらしいけど、絶望的に分かりにくくてめっちゃつらかった。かといってこの辺の知見全くないのでどうこうできるアレもなく...。
