# socket.io で CORS にハマったメモ

`api.hoge.jp` で `socket.io` を走らせてるときに `hoge.jp` から Websocketで通信しようとしたら案の定 `CORS` エラーが出てハマった。`node.js` の `Express` では適当にミドルウェア書いておけば抜けられるのは知っていたのだけれど、`socket.io` でどうすればいいのかわからなかった。

https://groups.google.com/forum/#!topic/socket_io/Fkq9Pyc8s6E

に従って

```
app = express()

server = http.createServer app

io = require('socket.io').listen server,
  origins: "hoge.jp:*"
```

と `listen` するときにオプションで指定できるようだ。アー盛大にハマった。
