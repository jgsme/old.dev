# VPSにgitのリモートリポジトリをつくる

初回のみ

```
% sudo mkdir -p /var/git/
% sudo chmod -R 775 /var/git
% sudo chown -R root:wheel /var/git
```

リポジトリ毎

```
% sudo mkdir -p /var/git/reponame.git
% cd /var/git/reponame.git
% git init --bare --shared=true
```

こうしておけばローカル側で

```
% git remote add origin ssh://user@ip:port/var/git/reponame.git
```

でリモートを追加するだけであとは `fetch` やら `push` やらできる。
