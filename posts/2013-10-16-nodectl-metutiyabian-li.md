{
  title: "nodectl めっちゃ便利",
  date: "2013-10-16",
  description: "nodectl めっちゃ便利"
}

https://github.com/geta6/nodectl

node.js のプロジェクトを走らせるときに、ファイルを監視して再起動だったり、環境やポートの情報も `.nodectl.json` に設定を書いておくだけでいい。便利。サンプルの json は README.md が詳しいので略。

今のところ、リクエストがくると `nginx -> (portで割り振り) -> nodectl -> node` みたいな順で処理される。
