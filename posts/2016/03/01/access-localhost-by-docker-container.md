# [Docker のコンテナからホストの localhost にアクセスする](/2016/03/01/access-localhost-by-docker-container.html)

Mac の Docker machine 内で Docker のコンテナを走らせるとホストのマシンの localhost にアクセスできなくて困ったのでメモ。

```
% docker-machine ssh default
$ ip route show 0.0.0.0/0
```

Docker のコンテナでシェル叩くとコマンドヒストリが残らないので...
