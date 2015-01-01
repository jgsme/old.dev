# [Haskell で Web サーバをつくってみる](making-web-server-with-haskell)

http://adit.io/posts/2013-04-15-making-a-website-with-haskell.html

を見ながら Scotty で Web サーバをつくってみる。

## Haskell のインストール

```
✈ brew install ghc
==> Installing ghc dependency: gmp
==> Downloading https://downloads.sf.net/project/machomebrew/Bottles/gmp-6.0.0a.mavericks.bottle.tar.gz
######################################################################## 100.0%
==> Pouring gmp-6.0.0a.mavericks.bottle.tar.gz
🍺  /usr/local/Cellar/gmp/6.0.0a: 15 files, 3.2M
==> Installing ghc
==> Downloading https://downloads.sf.net/project/machomebrew/Bottles/ghc-7.8.3.mavericks.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring ghc-7.8.3.mavericks.bottle.1.tar.gz
🍺  /usr/local/Cellar/ghc/7.8.3: 5742 files, 724M
```

brew で。

```
✈ brew install cabal-install
==> Downloading https://downloads.sf.net/project/machomebrew/Bottles/cabal-install-1.20.0.3_1.mavericks.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring cabal-install-1.20.0.3_1.mavericks.bottle.1.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> Summary
🍺  /usr/local/Cellar/cabal-install/1.20.0.3_1: 5 files, 18M
```

次に `cabal-install`。どうやら brew のやつは古いっぽくてアップデートを求められたのでアップデート。

```
✈ cabal install cabal-install
```

## `cabal sandbox init`

なんか `cabal sandbox` を使うといいらしいので使う。

## `todo.cabal` を写経

```
name:                todo
version:             0.0.1
synopsis:            My awesome todo-list app
homepage:            https://github.com/e-jigsaw/haskell-webserver-sample
license:             MIT
author:              jigsaw
maintainer:          m@jgs.me
category:            Web
build-type:          Simple
cabal-version:       >=1.8

executable todo
  main-is:             Main.hs
  -- other-modules:
  build-depends:       base ==4.6.*
                     , wai
                     , warp
                     , http-types
                     , resourcet
                     , scotty
                     , text
                     , bytestring
                     , blaze-html
                     , persistent ==1.3.*
                     , persistent-template ==1.3.*
                     , persistent-sqlite ==1.3.*
                     , persistent-postgresql ==1.3.*
                     , monad-logger ==0.3.0
                     , heroku
                     , transformers
                     , wai-middleware-static
                     , wai-extra
                     , time
```

## `Main.hs` を写経

```
{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty

main = scotty 3000 $ do
  get "/" $ do
    html "Hello World!!"
```

## エラーが出る

```
✈ cabal install
Resolving dependencies...
cabal: Could not resolve dependencies:
trying: Cabal-1.20.0.3/installed-ede... (user goal)
next goal: todo (user goal)
rejecting: todo-0.0.1 (conflict: Cabal => base==4.7.0.1/installed-c64..., todo
=> base==4.6.*)
Dependency tree exhaustively searched.

Note: when using a sandbox, all packages are required to have consistent
dependencies. Try reinstalling/unregistering the offending packages or
recreating the sandbox.
```

ちょっとよくわからないです。。。

ので、大人しく `cabal init` することにした。

```
✈ cabal init
Package name? [default: haskell-webserver-sample]
Package version? [default: 0.1.0.0]
Please choose a license:
 * 1) (none)
   2) GPL-2
   3) GPL-3
   4) LGPL-2.1
   5) LGPL-3
   6) AGPL-3
   7) BSD2
   8) BSD3
   9) MIT
  10) MPL-2.0
  11) Apache-2.0
  12) PublicDomain
  13) AllRightsReserved
  14) Other (specify)
Your choice? [default: (none)] 9
Author name? [default: jigsaw]
Maintainer email? [default: jigsaw@live.jp]
Project homepage URL? https://github.com/haskell-webserver-sample
Project synopsis? webserver sample
Project category:
 * 1) (none)
   2) Codec
   3) Concurrency
   4) Control
   5) Data
   6) Database
   7) Development
   8) Distribution
   9) Game
  10) Graphics
  11) Language
  12) Math
  13) Network
  14) Sound
  15) System
  16) Testing
  17) Text
  18) Web
  19) Other (specify)
Your choice? [default: (none)] 18
What does the package build:
   1) Library
   2) Executable
Your choice? 2
What is the main module of the executable:
 * 1) Main.hs
   2) Other (specify)
Your choice? [default: Main.hs]
What base language is the package written in:
 * 1) Haskell2010
   2) Haskell98
   3) Other (specify)
Your choice? [default: Haskell2010]
Include documentation on what each field means (y/n)? [default: n]

Guessing dependencies...

Warning: no package found providing Web.Scotty.

Generating LICENSE...
Generating Setup.hs...
Generating haskell-webserver-sample.cabal...

You may want to edit the .cabal file and add a Description field.
```

生成されたファイルはというと

`haskell-webserver-sample.cabal`:

```
-- Initial haskell-webserver-sample.cabal generated by cabal init.  For
-- further documentation, see http://haskell.org/cabal/users-guide/

name:                haskell-webserver-sample
version:             0.1.0.0
synopsis:            webserver sample
-- description:
homepage:            https://github.com/haskell-webserver-sample
license:             MIT
license-file:        LICENSE
author:              jigsaw
maintainer:          m@jgs.me
-- copyright:
category:            Web
build-type:          Simple
-- extra-source-files:
cabal-version:       >=1.10

executable haskell-webserver-sample
  main-is:             Main.hs
  -- other-modules:
  other-extensions:    OverloadedStrings
  build-depends:       base >=4.7 && <4.8
  -- hs-source-dirs:
  default-language:    Haskell2010
```

`LICENSE` も勝手に生成してくれてて優しい。

たぶん `scotty` がないよっていわれるだろうなとおもいつつ `cabal install` してみる

```
Main.hs:2:8:
    Could not find module ‘Web.Scotty’
    Use -v to see a list of the files searched for.
cabal: Error: some packages failed to install:
haskell-webserver-sample-0.1.0.0 failed during the building phase. The
exception was:
ExitFailure 1
```

ウッス。`haskell-webserver-sample.cabal` の `build-depends` に `scotty` を追加して `cabal install` しなおす。するとずるずる〜っと依存の解決をしてくれるのでしばらく待つ。すると `.cabal-sandbox/bin/haskell-webserver-sample` にバイナリができているのであとはそいつを実行すると

```
✈ .cabal-sandbox/bin/haskell-webserver-sample
Setting phasers to stun... (port 3000) (ctrl-c to quit)
```

あとは

```
✈ curl http://localhost:3000
Hello World!!%
```

wa~i!!

## 名前を表示するぞ

チュートリアルの次がルーティングの項目だったので、`GET /` で `name` を querystring で受けたら名前を出すやつをつくる。querystring は `name <- param "name"` みたいな感じで受け取れるようだ。

`Main.hs`:

```
{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Data.Monoid

main = scotty 3000 $ do
  get "/" $ do
    name <- param "name"
    text $ mconcat ["あけまして", name, "おめでとう"]
```

なにも考えずに `"あけまして" ++ name ++ "おめでとう"` ってやったらエラーが出てダメだった。チュートリアルにあるとおり `mconcat` を使うとできる。ちなみに `mconcat` は `Data.Monoid` を import しないといけなかった。とりあえずこれで

```
✈ curl http://localhost:3000/?name=yeah
あけましてyeahおめでとう%
```

yeah!(ところで `Monoid` って何)

ここまでやって、json で返すのを試そうとしてたら日本酒が完全にまわって倒れたので寝ました。あけましておめでとう。
