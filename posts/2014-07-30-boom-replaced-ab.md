# [boom で ab](/2014/07/30/boom-replaced-ab.html)


https://github.com/rakyll/boom

Go 製の ab っぽいツール。

```
✈ boom -n 1000 -c 100 http://jgs.me
1000 / 1000 Booooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo! 100.00 %

Summary:
  Total:	0.7682 secs.
  Slowest:	0.6583 secs.
  Fastest:	0.0191 secs.
  Average:	0.0629 secs.
  Requests/sec:	1301.6891
  Total Data Received:	966000 bytes.
  Response Size per Request:	966 bytes.

Status code distribution:
  [200]	1000 responses

Response time histogram:
  0.019 [1]	|
  0.083 [850]	|∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  0.147 [63]	|∎∎
  0.211 [35]	|∎
  0.275 [0]	|
  0.339 [0]	|
  0.403 [0]	|
  0.467 [0]	|
  0.531 [0]	|
  0.594 [21]	|
  0.658 [30]	|∎

Latency distribution:
  10% in 0.0199 secs.
  25% in 0.0203 secs.
  50% in 0.0213 secs.
  75% in 0.0247 secs.
  90% in 0.1415 secs.
  95% in 0.5856 secs.
  99% in 0.6001 secs.
```

サマリーや、ヒストグラムが出たりするのがカッコいい。
