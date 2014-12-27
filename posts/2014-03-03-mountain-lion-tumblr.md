# Mountain Lion で tumblr のスライドショーをスクリーンセーバーにする

普段はホットコーナーでディスプレイのスリープをしているのだけれど、大きいサブディスプレイを使うとホットコーナーが死ぬので対策が必要になった。

むかしは簡単にtumblogのスライドショーがスクリーンセーバーとして使えたものの、Mountain Lionではそのあたりの機能が削られていたようで一工夫が必要だった。

おおむね http://desico.blogspot.jp/2012/09/mountain-liontumblr.html の通りにやればできる。それでも最新のものしか流れないのがイヤなので工夫する。

http://tumblub.jgs.me で tumblog をランダムにスライドショーする機能があるので、その json を rss にコンバートします。そのため、Yahoo! Pipes で json -> rss に変換した。

http://pipes.yahoo.com/pipes/pipe.info?_id=8312870908de0b6d814cd8e418d5112b

Union module が5つまで結合できるので、きりよく100件のポストを流すようなパイプにした。Yahoo! Pipes 相変わらず慣れない...。あとは、この pipe の吐き出す rss を iPhoto に食わせりゃいいんだけど、環境設定のスクリーンセーバーのところに iPhoto のフォトライブラリが選べなくて困ってたら、どうやら iPhoto になんか写真が入ってないとフォトライブラリが出ないようになっているようで、適当に1枚放り込んだら出るようになった。よかった。

![](http://user-image.logdown.io/user/5835/blog/5854/post/183191/n8MNoOezS9e57XAK1rhM_2014-03-05%2018_54_24.gif)

とりあえずこれで Alfred からスクリーンセーバー起動できるようになって便利になった。
