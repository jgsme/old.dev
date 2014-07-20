{
  title: "taberareloo で tumblr への投稿が 403 になるときの対処",
  date: "2013-12-12",
  description: "taberareloo で tumblr への投稿が 403 になるときの対処",
  url: "taberareloo-403"
}

taberareloo から tumblr に投稿しようとすると 403 が出て生きた心地がしなかった。

対処は簡単で、

https://gist.github.com/YungSang/7920406

からパッチを落としてきて、拡張機能のオプションページからパッチをインストールしてやると通る。
