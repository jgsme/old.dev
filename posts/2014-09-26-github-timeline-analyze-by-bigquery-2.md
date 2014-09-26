{
  title: "githubのtimelineをBigQueryで解析する(その2)",
  date: "2014-09-26",
  description: "githubのtimelineをBigQueryで解析する(その2)",
  url: "github-timeline-analyze-by-bigquery-2"
}

http://dev.jgs.me/posts/github-timeline-is-analyzable-on-bigquery/ のつづき。

試しに自分のアカウントでフィルタしたクエリを投げてみる。

```
select *
from [githubarchive:github.timeline]
where actor = 'e-jigsaw'
limit 100
```

すると

```
...
https://github.com/yutaono/__.swift,true,2014-06-07 05:19:01,false,__.swift will be an utility belt for Swift Language.,0,true,true,,0,false,__.swift,yutaono,0,1,2014-06-07 01:56:30,Swift,null,null,master,38039ef5991573d89944a552471f13b7,User,e-jigsaw,jigsaw,,"Shibuya, Tokyo, JAPAN",http://jgs.me,m@jgs.me,2014-06-07 07:47:29,true,e-jigsaw,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,started,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,https://github.com/yutaono/__.swift,WatchEvent
https://github.com/rainycape/magick,true,2013-10-11 10:45:10,true,ImageMagick bindings for Go (golang),13,false,true,,18618,false,magick,rainycape,3,52,2014-08-15 19:02:19,Go,null,null,master,38039ef5991573d89944a552471f13b7,User,e-jigsaw,jigsaw,CyberAgent Inc.,"Shibuya, Tokyo, JAPAN",http://jgs.me,m@jgs.me,2014-08-24 15:37:49,true,e-jigsaw,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,started,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,https://github.com/rainycape/magick,WatchEvent
...
```

みたいなやつが返ってくる(6.1s)。よくよく見てみると、やたら`null`が入っててなんだろうとおもったら、Starしたやつは`WatchEvent`が発火して、commitとかpushのときに埋まるカラムが`null`で埋まるようだ。

ということは、

```
select *
from [githubarchive:github.timeline]
where actor = 'e-jigsaw'
and type = 'WatchEvent'
order by created_at desc
limit 100
```

というようなやつを投げればよくて(6.2s)、これで自分の直近のStarしたリポジトリが見れる。バッチはどうやら1時間おきに走っているようで、ほぼ最新の情報も取得できているようだ。スゲー！

気が向いたらもうちょっと調べる。
