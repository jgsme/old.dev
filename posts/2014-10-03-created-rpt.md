# tumblrからランダムに写真を表示するサービスをつくった

https://github.com/jgsme/rpt

寿司が宇宙にいる様子がひたすら流れる [spacesushipic](http://spacesushipic.tumblr.com/) っていうアカウントが面白くて、適当な写真をサッと取得できたらいいなー、という着想から。

```
http://rpt.jgs.me/spacesushipic
```

にアクセスすると宇宙寿司の画像が取得できる。カスタムドメインにも対応していて

```
http://rpt.jgs.me/tumblr.jgs.me (R-18)
```

みたいな感じでいける。

Tumblr の API は [tumblub](http://tumblub.jgs.me) でだいぶやったのですんなりいった。tumblub もずいぶんコードが老朽化して見えるのでメンテしてあげたい。
