# psql -> tsv
http://d.hatena.ne.jp/choplin/20101222/1292995497

psql で tsv を出したい。

```
psql -h host.com -d dbname -p 5439 -U user -W -c 'select * from Waiwai' -A -F '    ' -t > hoge.tsv
```

`-F` のあとには `TAB` を直に入力する。`C-v` で入力できるようになるのをはじめて知った。
