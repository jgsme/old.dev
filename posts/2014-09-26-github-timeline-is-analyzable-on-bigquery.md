{
  title: "githubのtimelineがbigqueryで解析できる",
  date: "2014-09-26",
  description: "githubのtimelineがbigqueryで解析できる",
  url: "github-timeline-is-analyzable-on-bigquery"
}

http://www.githubarchive.org/

[Githut](http://githut.info/)という Github の解析サイトがあって、仕掛けを調べていたらGithubはpublicなtimelineをオープンデータとして公開しているらしい。

Githutの[README](https://github.com/littleark/githut/blob/da6e8e89c33c3eb93b106b1c0d45d5681efb2da5/README.md)にもある通り

```
select
  repository_language,
  count(distinct(repository_url)) as active_repos_by_url,
  YEAR(created_at) as year,
  QUARTER(created_at) as quarter,
from [githubarchive:github.timeline]
where
    type="PushEvent"
group by
  repository_language,
  year,
  quarter
order by
  repository_language,
  year DESC,
  quarter DESC
```

みたいなSQLを書くと言語毎のPush量みたいなやつが見れたりする。ほいではStarはどうなのかなあ、とおもったら`githubarchive:github.timeline`のスキーマの`type`にStar的なやつがなかったので見れなかった。

2014/09/26現在、`githubarchive:github.timeline`は`249,308,569`のRowがあって、サイズは154GBもあるんだそうだ。それがものの10s程度で解析できるのでBigQueryスゲーなとおもいます。
