# [Wercker v2その2](/2015/10/22/wercker-v2-2.html)

以前 Wercker が Docker からビルドするようになったという話を書いたのだが([参照](http://dev.jgs.me/2015/06/24/wercker-v2.html))そのことをすっかり忘れて `Wercker.yml` をアップデートすることがあって以前と状況が変わっていたので。ちなみに Node.js のなんかをビルドする場合の話。

Node.js のメジャーリリースバージョンである v4 が(Node.js になってもリリースが早く既に `v4.2.1` である...)Docker Hub にアップロードされているので、以前

```
box: nodesource/trusty:iojs-1.8.1
```

としていたのを(少し前の話だけど、当時は `iojs-1.8.1` だったのか...)

```
box: node:latest
```

やら、もうちょいバージョンを狭める場合には

```
box: node:4
```

とか

```
box: node:4.2
```

なんかにすればよさそう。

また、`devDependencies` がインストールされない問題は既に解決されていて、上記の `node` オフィシャルイメージであれば `npm-install` step でインストールされていた。

めでたしめでたし。
