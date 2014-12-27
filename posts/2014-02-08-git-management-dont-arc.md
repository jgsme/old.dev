# [git で管理しているディレクトリの不要なファイルを消す](/2014/02/08/git-management-dont-arc.html)

章毎にファイルを分けてTeXしていると、ついうっかり子ファイル編集時にビルドしてしまってディレクトリにTeXデブリが散乱してしまう。いちいち消すのはめんどくさいので、gitのコミット時にgitで管理しているファイル以外をまとめて吹き飛ばしたい。

http://transitive.info/article/git/command/clean/

.gitignore に不要な拡張子を列挙しているので、`-X`オプションで削除できる。

```
% git clean -Xf
```
