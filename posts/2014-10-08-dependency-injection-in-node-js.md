{
  title: "bottlejsでDIを試す",
  date: "2014-10-08",
  description: "bottlejsでDIを試す",
  url: "dependency-injection-in-node-js"
}

https://github.com/young-steveo/bottlejs

# tl;dr

* `bottlejs` を使うと最小構成ぐらいの DI ができる
* 依存しているモジュールやライブラリをきれいにまとめて扱えるようになるので便利
* 記述量が増えたり、呼び出し元で呼び出すモジュールの依存関係を把握してないといけなくなったりするデメリットもある

# BottleJS について

BottleJS は Javascript/Node.js の DI の micro container だ。

```js
var Barley = function() {};
var Hops = function() {};
var Water = function() {};
var Beer = function(barley, hops, water) { /* A beer service, :yum: */ };
```

これで

```js
var bottle = new Bottle();
bottle.service('Barley', Barley);
bottle.service('Hops', Hops);
bottle.service('Water', Water);
bottle.service('Beer', Beer, 'Barley', 'Hops', 'Water');
```

こういうことができるようになるらしい。サンプルコードがモジュールの名前ともマッチしていてすげーよかったので試してみることにした。

試してみると、Node.js で抱えるいくつかの問題を解決できることに気付いたので試しにこれに乗っかってコードを書いてみている。

# いいところ

## テストでモックを作るのが楽になる

例えば、`request` とかを使って外部と通信するようなモジュールをテストする場合、`sinon` とかで `fakeserver` を作ったりして試すことになるとおもうんだけど、そもそも `request` 自体を差し替え可能にしておくことでこれをしなくてよくなる。

```coffee
module.exports = class Some
  constructor: (@request)->

  get: (url)->
    @request url, (err, res, body)-> # ...
```

というような `lib/some.coffee` を用意して

```coffee
bottle = new Bottle()
bottle.service 'request', -> require 'request'
bottle.service 'Some', require('./lib/some'), 'request'

bottle.container.Some.get url
```

とすることで `request` を注入することができる。テストでは

```coffee

describe 'Some', ->
  it 'blah blah', ->
    bottle = new Bottle()
    bottle.service 'request', -> (str, callback)-> callback null, null, 'fake response'
    bottle.service 'Some', require('./lib/some'), 'request'
    bottle.container.Some.get # ...
```

みたいな感じでテストを書けるようになる。`request` がエラったときを試したいときは

```coffee
bottle.service 'request', -> (str, callback)-> callback new Error('blah')
```

というようにしてやれば強制的にエラーを発生させて挙動を確認することができる。

## `require` が相対パスで解決されるのが困る問題をちょっと緩和できる

node.js の `require` はモジュール名でない場合相対パスで解決されるので「あれ？あのモジュールってこのファイルからだとどうなるんだっけ...」みたいなのが発生する。これが `bottlejs` だと依存モジュールをその場で呼び出すことになるのでちょっと緩和できる(とおもう)。

```
|--- index.coffee
|--- client
     |--- model
          |--- some.coffee
     |--- controller
          |--- some.coffee
|--- util
     |--- some.coffee
```

というような構成だったときに

```coffee
module.exports = class SomeController
  constructor: ->
    @model = require '../model/some'
    @someutil  = require '../../util/some'
```

みたいな感じだったやつが、`SomeController` 側では

```coffee
module.exports = class SomeController
  constructor: (@model, @someutil)->
```

でよくなって、これを使うコード中で

```coffee
bottle = new Bottle()
bottle.service 'SomeUtil', require './util/some'
bottle.service 'SomeModel', require './client/model/some'
bottle.service 'SomeController', require './client/controller/some', 'SomeModel', 'SomeUtil'
```

としてやればよくなる。

## CoffeeScript の class 構文と相性がよさそう

上にも書いてきた通り、`constructor` に依存の解決系を書いて各メソッドでそれらを使ったコードを書くみたいな感じで書けるのでスッキリしていい。

# よくないところ

## 記述することは増える

`bottle =...` みたいな依存管理系のコードが増えるので記述量自体は増えるとおもう。

## いちいちモジュールの依存まわりを呼び出し元が知ってないといけなくなる

モジュールで `require` していれば、呼び出し元がそのモジュールがどんなモジュールに依存してるかを知らなくても呼び出すことができるが、上のようなコードスタイルにすると呼び出す前に依存を解決しないといけなくなるので呼び出すモジュールがなにに依存してるか確認してそれを注入してやらないといけなくなる手間が発生する。

もうしばらく使ってみたいとおもいます。
