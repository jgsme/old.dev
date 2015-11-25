# [npm run-scripts から watch する](/2015/11/25/watch-by-npm-run-scripts.html)

先日 `npm-run-all` を使ってビルドスクリプトなどを `npm run-script` に寄せるようにしたが(http://dev.jgs.me/2015/10/28/alpine-linux.html)これに `gulp.watch` 的な機構を載せようという試み。

これまでは若干面倒ながらも Atom で `cmd+b` でもってビルドをしていたのだけれど、さすがに面倒になってきたので watch して自動でビルドするように変更した。`npm-run-all` が glob のインターフェイスを持っているので、できれば glob のインターフェイスで watch するファイルを指定してコマンドを走らせたい。探してみたところ、`chokidar-cli` というパッケージを使えばあっさりだった。

```js
"scripts": {
  "watch": "npm-run-all -p watch:*",
  "watch:ls": "chokidar '**/*.ls' -c 'npm run build:bundle'",
  "watch:jade": "chokidar '**/*.jade' -c 'npm run build:jade'"
}
```

というような感じで指定してやると `npm run watch` で監視が走るようになる。これに

```js
"scripts": {
  "dev": "npm-run-all clean build -p watch serve",
  "serve": "static -p $npm_package_config_PORT $npm_package_config_DEST"
}
```

`node-static` でサーブするようにしていれば `npm run dev` でサーブと監視を開始することができる。便利。あとは Atom か Notification center あたりにビルド完了を notify したいなあ〜。
