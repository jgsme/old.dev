{
  title: "coffee-script を 1.7 にしたら mocha が死ぬときの対応",
  date: "2014-02-03",
  description: "coffee-script を 1.7 にしたら mocha が死ぬときの対応"
}

coffee-script のバージョン1.7がリリースされたので、アップデートしたら mocha が

```
nction (exports, require, module, __filename, __dirname) { describe "

SyntaxError: Unexpected string
...
```

というエラーで死ぬようになったので調べてみたところ

[describing how to compile CoffeeScript 1.7 · a807007 · visionmedia/mocha](https://github.com/visionmedia/mocha/commit/a807007661e098484a682db9f6bbe3177a0f416b)

1.7+ では、`mocha.opts` もしくは CLI のオプション `--compilers coffee:coffee-script` を `--compilers coffee:coffee-script/register` に変えなくてはいけないとのこと。ここを直すだけで通るようになった。
