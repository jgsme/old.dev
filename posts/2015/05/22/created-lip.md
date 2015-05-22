# [nip というツールを fork して lip というツールを作った](/2015/05/22/created-lip.html)

https://github.com/e-jigsaw/lip

nip というツールがトレンドにあがっていてシェル上で

```
nip 'function(l) { return /^var/.test(l); }' lines-that-start-with-var.txt
```

こんな感じでちょっとした js のコードを書いて各行処理などをできるようにするという雰囲気。

README がまだオリジナルのままなんだけど、コードを書く部分を LiveScript に変更した lip というツールをつくった。`lip` は既に登録されていたので scoped modules を使って `@jigsaw/lip` に公開した。

```
npm install -g @jigsaw/lip
```

でインストールすればグローバルで使えるし、パッケージでも lip をいれておくと npm run-scripts 上でちょっとした処理をしたいときなんかに使えたりしないかなあ〜とおもったり。coffee よりはワンライナー書きやすいとおもうし、prelude を使えば便利メソッドも使える(とはいえ、まだ prelude を require しておくモードがないのでいずれ追加したい)しいいんじゃないかとおもう。

CLI ツールといえば、LiveScript friendly な lson という altjson を CLI からコンパイルできるツールもつくった。

https://github.com/e-jigsaw/lson-cli

ガツガツ整えていくぞ。
