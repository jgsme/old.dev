# [このブログのアップデートをした](/2015/01/16/updated-blog.html)

年末年始の休みの期間中に、突然このブログを gulp ベースに移行してより使い勝手良く書けるようにしたくなってざくざくコードを書いた。

https://github.com/jgsme/dev/pull/10

もともと `CabinJS` という grunt ベースのスタティックブログジェネレータを使ってやっていたのだけど、そもそも grunt に愛想を尽かして gulp をよく使ってるのに、一番使ってるのが grunt みたいな感じになるのが我慢ならなかった。

ブログとして必要な機能として

* md で書ける
* url の構造は `/yyyy/mm/dd/title.html` というような感じにしたい
* アーカイブページがほしい

あたりが最低ラインということで、これらのものを生成できる `gulpfile` を書けばよい。最初は `gulpfile` にガツガツコードを書いていたのだけれど、見通しが大変に悪くなるので `gulp` というディレクトリをつくってそこに `task.coffee` というタスクのファイルをつくって

```coffee
[
  'task'
].forEach (name)-> gulp.task name, require "./gulp/#{name}"
```

というコードを `gulpfile` に書いておくだけで必要なタスクをロードして使えるし、各タスクのコードで必要なモジュールを `require` するようになって `gulpfile` の `require` 節が大幅に短くできて良い。

こうすると、変数とかで困るようになるわけだけど、これも `exports.hoge = hoge = 'value'` というような感じにして、各タスクからは `{hoge} = require '../gulpfile'` などと書いてやればよいだけになる。

## 記事ページの生成

```coffee
gulp.src paths.posts
  .pipe mark()
  .pipe article()
  .pipe jade('src/page.jade')
  .pipe article()
  .pipe publish(paths.dest)
```

元の記事を markdown のプラグインで html に変換して、そのあと `article` フォーマットっていう勝手なフォーマットに変換して、それをレイアウトのテンプレートの記事部分に埋め込み、再度 `article` フォーマットに変換してファイル名の日付を基に html のファイルを生成する、というのがおおまかな流れ。

`article` は

```coffee
article =
  body: '<h1>article title</h1><p>article contents</p>'
  date:
    year: '2014'
    month: '12'
    day: '27'
  url: 'awesome-title'
# https://github.com/e-jigsaw/gulp-article/blob/master/README.md#example
```

というようなフォーマット。これをインターフェースにして埋め込みやったり、記事を出力したりするような仕組みにした。npm のモジュールにしてみたんだけどあんまり汎用なものではないので、もしかしたらヘルパーモジュールみたいな感じで本体に取り込むかもしれない。

## アーカイブページ

アーカイブページをつくるのは、複数ステップにまたがるのでタスクを分けて、それらをシーケンス実行することで落ち着いた。そこへ至るまでが結構大変だったけど

### Step1 JSON データをつくる

```coffee
gulp.src 'posts',
    read: false
  .pipe archive("#{paths.dest}/archives")
```

`posts` 下に markdown の記事が格納されているので、これらをアーカイブストリームに流す。`read: false` をつけるとファイルがロードされず、パスだけ渡せる。アーカイブストリームでは、すべての記事を20コずつに分割した json のファイル、年次の json、月次の json を作ってそれらを出力する。

### Step2 JSON データを基に HTML をつくる

```coffee
gulp.src "#{paths.dest}/archives/*.json"
    .pipe jade('src/archive.jade')
    .pipe rename
      extname: '.html'
    .pipe gulp.dest("#{paths.dest}/archives")
```

Step1 で出力した json を読んできて記事の出力でも使っていた jade のローカル変数の埋め込みができるプラグインで html を出力する。その際の全体アーカイブ、年次アーカイブなどのページの変化は jade の中で吸収することにした。

### Step3 `/archive/index.html` をつくる

```coffee
fs.readdir "#{paths.dest}/archives", (err, files)->
files = _.filter files, (file)-> /^page-\d*\.html$/.test file
gulp.src "#{paths.dest}/archives/#{_.head(files)}"
  .pipe rename('index.html')
  .pipe gulp.dest("#{paths.dest}/archives")
```

やっぱり `/archive` で見たいよなあ、とおもって別でつくった。

というような流れを経てアーカイブページを生成した。

## RSS

```coffee
fs.readdir 'posts', (err, files)->
files = _.map files.slice(-20), (file)-> "posts/#{file}"
gulp.src files.reverse()
  .pipe rss
    title: 'kaihatsu'
    description: 'development log'
    feed_url: 'http://dev.jgs.me/feed.xml'
    site_url: 'http://dev.jgs.me'
    image_url: 'http://dev.jgs.me/icon.png'
    author: 'jigsaw'
    copyright: '(c) 2015 jigsaw'
    updated: new Date()
  .pipe gulp.dest("#{paths.dest}/feed.xml")
```

アーカイブついでに、RSS の話も。最初は RSS のプラグインを使っていたけど、生成する RSS がバグっててパースに失敗するので(ソースコードまで追ったんだけど、github に上がってるコードと npm に上がってるコードが同じバージョンなのに違くて、コミットも活発じゃなかった)自作した。

## ファビコン

昨今はファビコンに求められるハードルが高くて、とてもたくさん用意しないといけないらしい。が、 http://realfavicongenerator.net/ を使うと画像を投げるだけでファビコンのセットを用意してくれるのでとても便利だった。Github 上で情報を管理しているっぽいところもいいところ。

## CSS

https://github.com/sindresorhus/github-markdown-css で GFM 準拠のデザインをはめて、追加でヘッダとかフッタのデザインをいれる感じにしている。FW では一応 Yahoo の Pure を使っている。

## Scaffold

最初は自前ライブラリの `tmpl` から生成できるようにしていたけど、やっぱり分離してるのは気持ち悪いよなとおもって gulp のタスクにして、それを `npm run write` で生成できるようにした。`tmpl` でも使っているけど、inquirer がレボリューショナリー便利。

## Wercker からデプロイ

最初は、書いたら `npm run deploy` すればいいやとおもっていたのだけれど、書いてデプロイしたけど記事データの方を push するのを忘れて別のマシンで記事がデプロイできない、という問題に直面した。(最近は4台ぐらいマシンを常用していてやばい)

なので、書くフローを

1. 書く
2. push
3. PR
4. master に merge
5. deploy

という風にした。Wercker の設定で特定の branch のビルドを自動でデプロイすることができるので、master のビルドが通ったら自動的に gh-pages に push されるようにした。

こうして快適な環境を完成させることができた...!ひと通りやってみて、gulp にもだいぶ明るくなったし、RSS とか wercker あたりもより知れて良かった。快適になったので、今後もモリモリと記事を書いていきたい。
