# [Alpine Linux](/2015/10/28/alpine-linux.html)

https://github.com/mhart/alpine-node

↑で知ったのだけれど、Alpine Linux というイメージがあるらしい。

```
✈ docker rmi `docker images -qa`
```

するとディスクがメチャ空くでおなじみの Docker のイメージサイズをコンパクトにできるそうだ。最新版である(もうすぐ v5 が出るらしいが...) `v4.2.1` を pull してみると

```
✈ docker images
REPOSITORY                         TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
node                               latest              db4c9d65b7e4        4 days ago          641.7 MB
mhart/alpine-node                  latest              42e56d1e80c4        2 weeks ago         35.02 MB
```

`641.7MB` -> `35.02MB` と大変スッキリサイズになっているのが分かる。単純な Node のみでよいコンテナ(依存モジュールがネイティブバインディングあったりすると面倒そうだ...)であればこれで十分な気がする。

...とおもって、このブログも `Makefile` でタスクを書いてたのを `npm-run-all` を使って `npm run-scripts` に書けば `alpine-node` でビルドできるかも〜と書きなおしてみた。

https://github.com/jgsme/dev/pull/77

```js
"scripts": {
  "build": "npm-run-all build:before -p build:assets build:generate",
  "build:before": "mkdir -p $npm_package_config_DEST",
  "build:assets": "npm-run-all build:before -p build:assets:*",
  "build:assets:gfm": "cp node_modules/github-markdown-css/github-markdown.css $npm_package_config_DEST",
  "build:assets:cname": "cp src/CNAME $npm_package_config_DEST",
  "build:assets:favicon": "cp -r src/favicons/* $npm_package_config_DEST",
  "build:assets:live": "lsc -cbo $npm_package_config_DEST src/*.ls",
  "build:assets:stylus": "stylus src/*.styl --out $npm_package_config_DEST -c",
  "build:generate": " npm-run-all build:before -p build:generate:*",
  "build:generate:article": "lsc scripts/article.ls",
  "build:generate:indexpage": "lsc scripts/indexpage.ls",
  "build:generate:archive": "lsc scripts/archive.ls",
  "build:generate:rss": "lsc scripts/rss.ls",
  "clean": "rm -rf $npm_package_config_DEST",
  "serve": "static -p $npm_package_config_PORT $npm_package_config_DEST",
  "write": "lsc scripts/write.ls"
}
```

`make` でやっていたときは `make` でがんばる気がしなくて直列で実行してたのを並列化させてより高速にビルドできるようになった。ハマったのは変数のところで、前から `npm config` があるのは知っていたのだけれど、それをうまいこと扱う方法がよく分からなかった。config は

```js
"config": {
  "DEST": "build",
  "PORT": "3000"
}
```

こういう感じに書いておくと環境変数に `npm_package_config_DEST` というような感じで参照できる。環境変数なので、`script` フィールドでは `$npm_package_config_DEST` としてやればうまく動くようだった。これを上書きするときは

```
✈ npm run serve --dev:PORT=3001
```

というような感じで `--<package 名>:<変数名>=<変数>` というような形式で読んでやると上書きすることができた。

さてあとは Wercker でビルドするだけだぞ〜とおもったら、Wercker だと Alpine Linux ベースのイメージはバグで pull したあとに終了してしまうらしい。。。。

当初の目的が全く果たせなくなったが、諦めてオフィシャルの `node` でビルドするように戻して今日のところはフィニッシュした。
