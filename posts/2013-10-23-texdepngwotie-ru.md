# texでpngを貼る
TeXで `.png` ファイルを貼るのがダルかったのでメモ。

画像を貼るときは `\includegraphics` というクソ長いタグを使う。

```
\includegraphics[width=8cm]{hoge.png}
```

同じディレクトリに `hoge.png` を置いておいたら、`hoge.bb` がねえよ！って怒られるのでググってみると `extractbb` というコマンドで `.bb` ファイルに変換しておかなればいけないらしい。

```
% extractbb hoge.png
```

すると、`hoge.xbb` というファイルが生成されるのでこれでいいのかとおもったらやっぱりダメで、`hoge.bb` にリネームしてやらないといけない。このあたりを自動化するスクリプトを準備しようとおもった。あとでな！

このままだと、図番とかがつけられないので `figure` ブロックを使って図番やキャプションをつける。

```
  \begin{figure}
    \includegraphics[width=8cm]{hoge.png}
    \caption{TeXダルいしMarkdownで書きたい}
    \label{fig:1}
  \end{figure}
```

みたいな感じ。これだと、これを書いたところに挿入されない。なるほど、論文とかはちょっと意味わからん位置に図があったりするわけか、と納得。
