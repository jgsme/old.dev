# coffee-script では package が reserved になってるので変数として使えない

http://coffeescript.org/documentation/docs/lexer.html#section-66

* package は coffee-script での予約語らしい

## 詳細

なんの気なしに

```
packages.forEach (package)->
  ...
```

的なコードを書いたら、linter に怒られて、そんなバナナ〜とおもってコンパイルしてみたらホントにコンパイルエラーになったので調べてみた。coffee-script の lexer のコードを検索してみたら `package` は予約語だった。それだけっちゃそれだけなんだけど、よくよく見てみると `public` や `static`, `yield` なんかも予約語になっていてふーん、なるほどねー、となった。
