# node.jsのmongooseでnestしたobjectをpopulateする

`node.js` の `mongoose` でネストしたドキュメントを `populate` したいときの話。

`3.6` 系から `populate` の仕様が変わるようで、以前のように

```
Document.find().populate("comment.author").exec (err, docs)->
```

のようなコードでは `populate` できなくなった。代わりに

```
Document.find().populate("comment").exec (err, docs)->
  User.populate docs,
    path: "comment.author"
  , (err, docs)->
```

のように書いてやると当該部分が `populate` される。ちょっとややこしいなあ。

https://github.com/LearnBoost/mongoose/issues/1377
