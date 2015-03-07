# [diary のデザインを刷新した](/2015/03/07/redesign-diary.html)

http://diary.jgs.me

![](https://cloud.githubusercontent.com/assets/557961/6541502/5c7860ca-c518-11e4-8773-e708cc089468.png)

Tumblr は独自のマークアップ `{block:Post}` みたいなのをふんだんに使ったマークアップを一枚絵にして出さないといけないので結構大変。2013年の4月から使っている前のテーマは、適当なシンプルなテーマから足し引きしたりして当時の自分にイイ感じのスタイルにしていた。すると [toihrk に参考にされていて](http://diary.jgs.me/post/112567782834/toihrk-toihrk-nikki)結構嬉しくなった。

とはいえ、もう2年近く同じスタイルで使い続けていたのでさすがに飽きてきてたのもあったし、イチから自分用のマークアップを書きたい欲求もあったのでごっそり書き起こした。

http://github.com/jgsme/diary

さすがにこの2015年にあの一枚絵をモリッと書いていくのはハートブロークンなので Jade と Stylus でひたすらに切り刻んで見通しを良くした。全体のレイアウトは [index.jade](https://github.com/jgsme/diary/blob/db976532f04bf0a4cb1af8ec5015a96c175927ea/src/index.jade) のようなひたすら include するやつにして、各パーツで [posts/photo/template.jade](https://github.com/jgsme/diary/blob/db976532f04bf0a4cb1af8ec5015a96c175927ea/src/posts/photo/template.jade) と [posts/photo/style.styl](https://github.com/jgsme/diary/blob/db976532f04bf0a4cb1af8ec5015a96c175927ea/src/posts/photo/style.styl) のような簡単な Jade と Stylus を持つようにして全体の見通しをめっちゃ良くした。

gulp で例の一枚絵を錬成してそれを Tumblr の Theme editor にコピペして確認して〜という作業をひたすら繰り返す。ここらへんもいっそライブプレビューぐらいできるようにしようかとおもったが、そっちの方にコストがかかりそうだったので愚直にコピペを繰り返した。

個人的な要件として

* コンテンツをデカく表示したい
* Tumblr のどの種類の投稿なのか見やすくしたい
* 字が読みやすい

あたりが大きかったのでそれぞれ

* コンテンツをデカく表示したい
  * -> 写真は横1024pxのやつを持ってきて100%表示
  * -> その他コンテンツも100%っぽい表示に
* Tumblr のどの種類の投稿なのか見やすくしたい
  * -> 日付のバーを Tumblr の投稿種別アイコンの色に
  * -> Link や Video はコンテンツの隙間を種別色と同じで埋める
* 字が読みやすい
  * -> 大きめ明朝体が自分の中でブームなのでそういう感じ

というような対応をした。だいぶ気に入ってるのでしばらくはこれでいきます。あと、リポジトリのコード類もまあまあ再利用効くとおもうので fork して自分の好きなようにスタイルを変えたり構成を変えたりして使えるかとおもうのでよろしければ。ただ、自分が全然使わない Chat とか Audio あたりは手抜き状態なのでそこだけはお気をつけくださいー。
