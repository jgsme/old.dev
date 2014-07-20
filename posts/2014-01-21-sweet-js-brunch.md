{
  title: "sweet-js-brunch をつくった",
  date: "2014-01-21",
  description: "sweet-js-brunch をつくった",
  url: "made-sweet-js-brunch"
}

https://github.com/e-jigsaw/sweet-js-brunch

Chaplin.js (http://chaplinjs.org/) がよさげで、Chaplin のプロダクトのビルドツールとして brunch (http://brunch.io/) というツールが使われていて、便利そうだったのでぼちぼち触っていた。

Grunt (http://gruntjs.com/) にはじまる node.js まわりのビルドツール戦争は gulp (http://gulpjs.com/), brunch のナウい勢から「やっぱり Makefile で十分だよ」派、「は？いまどき make ？CMake でしょ」派、「Javascript 書いてるやつは死ね Rake がいいよ」派、などなどレジェンド勢まで百花繚乱の様相を呈してまいりました。こっちは選択肢が豊富で参るけど。

brunch のいいところは [Grunt止めて、mincer止めて、Brunchに乗り換えた - Qiita [キータ]](http://qiita.com/hadashiA/items/9f5fb4134bf87a560b82) あたりが参考になるかも。

ところで、Javascript にマクロを提供する sweet.js (http://sweetjs.org/) がなかなか野心的なプロダクトで

> Do you want to use class syntax but don’t want to wait for ES6? Add them yourself with just a couple lines of code!

とのこと。実際のプロダクトでどう使っていくのがいいのかとかは全く見えないでいるけど、とりあえず準備のために brunch の plugin をつくっておくことにした。

# 使ってるアーキテクチャ

## コード

* Coffeescript (http://coffeescript.org/)

もうこれなしではJavascript書く気力が起きないというか。

## テスト

* Mocha (http://visionmedia.github.io/mocha/)
* Chai (http://chaijs.com/)
* travis (https://travis-ci.org/)

Mocha はテストスイートを提供してくれるライブラリ。Chai はアサーションの構文を提供してくれるライブラリ。travis はクラウドでテストを実行してくれる便利なやつ。

## ビルドツール

* Cake (http://coffeescript.org/#cake)

上で散々ビルドツールの名前を上げたけど、単純に Coffeescript のビルドだけなら Coffee に付属している Cake で十分という感じ。Mocha からテストするときもオプションをつけてやればいちいち Javascript にビルドしなくてもいいので便利。

## その他

* David (https://david-dm.org/)
* Version Badge (http://badge.fury.io/)

Readme をにぎやかにしてくれるやつら。David は `package.json` の依存のアップデート情報を表示してくれるし、Version badge は npm の現在バージョンを表示してくれる。

# あとがき

だいたい完成したあとに、Coveralls でカバレッジのログをとろうとしたのだけれど、Coffeescript でカバレッジを計測するのが未だにうまくいかない。とはいえ、「カバレッジ100%だから何」という話もあるし自分にとってもそこまで重要なものではなかったのであまり固執せずに見送った。
