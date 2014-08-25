{
  title: "ngrok 便利",
  date: "2014-08-25",
  description: "ngrok 便利",
  url: "ngrok-awesome"
}

https://ngrok.com/

ngrok、なんとなく star つけたのがだいぶ前で触れてすらいなかったのだけれど、今日携帯端末向けにデバッグするために使ったらめっちゃ便利だった。

```
% brew install ngrok
% ngrok 5000
```

すると `localhost:5000` で受けてるやつに URL が振られて携帯端末からローカルにアクセスできるようになる。めっちゃ便利。

Vagrant Share に同じ機能があるとのことなんだけれど、Vagrant まで必要になったらそちらを使えばいいし、そうじゃない程度のやつは ngrok で十分だなーとおもった。
