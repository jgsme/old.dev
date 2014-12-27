# twitter の userstream が突然調子悪くなる案件
 `node.js` から twitter の userstream を扱うのには、`ntwitter` は挙動がバギーなので `user-stream` を使っている。

https://github.com/aivis/user-stream

ログを見てみると `garbage` イベントを吐きまくっていた。当該部分を読んでみると

https://github.com/aivis/user-stream/blob/master/lib/user-stream.js#L131

```
try {
    //try parse & emit
    buffer = JSON.parse(buffer);
    parsed = true;
} catch(e) {
    stream.emit('garbage', buffer);
}
```

という感じで、`JSON.parse` に失敗したら `garbage` を吐くようになってる。`catch` 節で `buffer` をダンプしてみると確かにjsonデータがぶつ切れになっていて、そりゃあパースに失敗するよなあ、という感じ。

今は小康状態で時々出るぐらいなんだけど、困ったなー。いっちょフォークして直してやるか！...とおもったら、そういう時に限ってなかなか `garbage` が発火しなくて泣ける。

一旦様子見で。
