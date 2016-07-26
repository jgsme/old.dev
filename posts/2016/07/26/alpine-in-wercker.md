# [wercker で alpine が動くようになってた](/2016/07/26/alpine-in-wercker.html)

以前は Alpine Linux だと即死だったが、FAQ が追加されてて動くようになってた。

`wercker.yml` で `cmd` を `/bin/sh` にしてやればいいらしい。

```
box:
  id: alpine
  cmd: /bin/sh
```

http://devcenter.wercker.com/docs/faq/alpine-faq.html
