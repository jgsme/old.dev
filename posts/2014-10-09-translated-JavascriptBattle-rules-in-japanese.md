# JavascriptBattleのルールを日本語訳してみた

https://github.com/JavascriptBattle/hero-starter

JavascriptBattle という AI を作って戦わせる系のゲームを発見して、結構面白そうだったので遊んでみている。

参加するのは簡単で、[Javascript Battle](http://www.javascriptbattle.com/) から Github のアカウントで Join できる。Join したら、[JavascriptBattle/hero-starter](https://github.com/JavascriptBattle/hero-starter) を fork して、`hero.js` を書き換えて push すれば OK。

最初は `hero.js` でコメントアウトされている移動関数を書き換えて試していくとなんとなく掴める。とはいえ、ルールをちゃんと分かってないと AI つくるもなにもないので、ちゃんと読むついでに[日本語訳](https://github.com/e-jigsaw/hero-starter/blob/358cfaa45d11aeba50359b9171b135e06e40cb0f/RULES.ja.md)してみることにした。合ってるか分からないので誰かチェックしてもらえると嬉しい。いつでも PR あげてください。

ルールとしては結構単純で、自分がなるべくダメージくらわないように敵ヒーローを殴るプレイか、マイン掘って1250ターン耐えるか、みたいなあたりが大きな戦略としてあって、それを基にどんな AI を作るかというところがポイントになるとおもう。

CLI だと将棋盤みたいな味気ない画面なんだけど、Web だとチマチマヒーローたちが動くプレイヤーもついてるので面白い。
