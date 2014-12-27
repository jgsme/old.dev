# nginxでサブドメインの指定

nginxでサブドメインの指定をするときにはサブドメインの分だけ `server` を書いておけばいいっぽい。

```
% vim /etc/nginx/conf.d/virtual.conf
```

```
server {
  listen 80;
  server_name domain.com;
  location / {
    proxy_pass http://127.0.0.1:5000
  }
}

server {
  listen 80;
  server_name sub.domain.com;
  location / {
    proxy_pass http://127.0.0.1:5000
  }
}
```

この辺の動作仕掛け謎なので見識を深めたく。
