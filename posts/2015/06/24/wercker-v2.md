# [Wercker の新バージョンがリリースされて Docker ベースになっていた](/2015/06/24/wercker-v2.html)

Wercker がいつの間にかアップデートされていて、いま新しくアプリケーションを作成すると新しいスタック(Ewok というらしい)で作成される。ので、古い yml ファイルをそのまま使うとエラーが出る。

大きな変更点としては、box を Docker Hub からとってこれるようになったところだろう。

```
box: nodesource/trusty:iojs-1.8.1
```

とすると Docker Hub から Ubuntu + iojs@1.8.1 なイメージがダウンロードされて使える。もし複数バージョンを試したい場合は Docker Hub で nvm なり nodebrew なり入ったイメージを指定するといいだろう。

## ハマりどころ

どうやらデフォルトで `NODE_ENV` が `production` に設定されているようで `npm-install` の Step で `devDependencies` のパッケージがインストールされなくなっていた。ついでにそれに依存していたテストもすっ転んだ。しょうがないので

```
- script:
    name: Set NODE_ENV
    code: export NODE_ENV=development
```

を追加してなんとかした。

## その他

ドキュメントは http://devcenter.wercker.com/docs/pipelines/stacks.html にまとまっている。ところで、このドキュメントのページは https://github.com/wercker/docs にあって、gulp で metalsmith の静的ページを Wercker でビルドしているようだ。オープンだし、ドッグフーディングしてるしとても好感がもてる。

Wercker でいくつか飼ってるのがあるので移行させねばだー。
