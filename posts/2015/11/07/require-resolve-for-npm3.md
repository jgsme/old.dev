# [require.resolve で npm3 に耐える](/2015/11/07/require-resolve-for-npm3.html)

`power-assert` がビルトインされたし `ava` つかってみっか〜とおもって `gulp-mocha` を `gulp-ava` に置き換えてみたらエラった。こいつぁプルリクチャンスだぜーとコード読んだり修正してみたりしたんだけど、解決方法が分からなかったので issue を立ててみたら一瞬で解決して OSS 楽しいなーとおもった。

https://github.com/sindresorhus/gulp-ava/issues/2

結局のところ、npm3 だと `node_modules` が flat になってしまって `gulp-ava/node_modules/.bin/ava` ではなくプロジェクトルートの `node_modules/.bin` にエイリアスが張られてしまうことによって引き起こされている。そこで、これを解決するのが [`require.resolve`](https://nodejs.org/api/globals.html#globals_require_resolve) で、こいつに <パッケージ名/ファイル名> を食わせてやればそいつのファイルパスを返してくれる API なのだー。(知らなかった)

npm の issues を見てると同様の事案が起きてるように見受けられるのでこれで解決できるかもしれない。
