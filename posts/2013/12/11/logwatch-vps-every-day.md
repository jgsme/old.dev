# [logwatch で vps のログを毎日チェックする](/2013/12/11/logwatch-vps-every-day.html)

http://dogmap.jp/2011/05/12/vps-security/

で logwatch が紹介されていたのでいれてみた。

http://www.happyquality.com/2012/02/02/1924.htm

ホントに

```
% sudo yum install logwatch
```

するだけでOK。

あとは

```
% sudo /usr/sbin/logwatch --print
```

で確認できる。しかし、`nginx` を使っているのでWebサーバのアクセスログが出ない。そこで

http://donabeneko.jp/blog/20121117103737.html

のような感じで `apache` のやつを `nginx` 向けにちょろっと改変するだけでよかった。

僕みたいな弱小ドメインでも

```
 /web.config.rar: 1 Time(s)
 /web.rar: 1 Time(s)
 /web.zip: 1 Time(s)
 /www.rar: 1 Time(s)
 /www.zip: 1 Time(s)
```

みたいなアタックがきているのがわかった。
