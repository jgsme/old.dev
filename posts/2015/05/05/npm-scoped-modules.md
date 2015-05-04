# [npm の scoped-modules 試してみた](/2015/05/05/npm-scoped-modules.html)

[The npm Blog — solving npm’s hard problem: naming packages](http://blog.npmjs.org/post/116936804365/solving-npms-hard-problem-naming-packages)

という記事が出ていて、ついに npm で `@ユーザ名/パッケージ名` という感じでパッケージ管理できるようになった。これを試しついでに最近あまり手入れしてなかった `tmpl` を scoped modules で公開してみた。

[@jigsaw/tmpl](https://www.npmjs.com/package/@jigsaw/tmpl)

ついでに LiveScript に変更したりなんやかんやしたけど、テンプレート関連を一括で書き換えるのが気合いが足りなかったので一旦 publish までやっちゃったから動かなかったりする。。

はてさて、一部で待望している人が多かったこの機能、どうなるでしょうね。
