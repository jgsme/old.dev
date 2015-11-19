# [JSConf.asia 1日目 メモと感想](/2015/11/19/jsconf-asia-day-1.html)

昨日の CSSConf.asia に引き続き、JSConf.asia に参加してきた。感想とメモ。

* #perfmatters - Tools for Apache Cordova
  * Cordova でのパフォーマンスチューニングの話が中心
  * しばらく Cordova には触ってなかったが相変わらずという印象だった
  * Webview からネイティブの API を XHR 経由で呼び出しているのでその辺はオーバーヘッドがすごい
  * 一方で WindowsPhone はネイティブで JS が走るのでパフォーマンスはいいらしい
  * DOM の anchor でページ遷移するのはコストなので `onclick` で処理する、とか CSS の gradient は遅いので gradient っぽい画像を用意してがんばろ！みたいなバッドノウハウ感がしんどい
* Web based 3D camera simulator for Perceptual Computing
  * JS で LeapMotion や Intel Realsense から値をとる話
  * Websocket でとれるらしい？
  * ラップトップがお亡くなりになったそうでデモなどがなく残念
* Gameprogramming in Javascript
  * CreateJS を使ってタイ語のタイピングゲームを作る話
  * タイ語はキーボードが4段x2あってつらそうだった
  * ちなみにタイでは日本語の UI しかないのにねこあつめが大人気らしい。ねこあつめすげえ
  * CreateJS はともかく RequireJS ってまだ現役なんだろうか
  * Gulp watch と browser-sync でデバッグしたりとか
  * ゲームを作るのは学習にも向いている
  * JS はクロスプラットフォーム向けにちょうどいい
* Modular vs Monolith
  * Node.js でアプリケーションを作る上でモジュールに分割して開発するか、モノリスで開発するか、という話
  * 大抵のときで YAGNI(You ain't gonna need it) とのこと
  * シンプルなモジュールを組み合わせるのはいいけど、早まったモジュール化は危険
    * statement
    * function
    * file
    * folder
    * internal package
    * external package
    * の順にオーバーヘッドがデカくなっていく
  * "抽象化はローカルの複雑性を緩和するが、グローバルの複雑性を増す"
  * "間違ったものは正しい理由によって作られる"
  * "flat is better than nested"
  * などなど心に刻んでおきたい金言が多かった
  * そして結論としては、最初はモノリス的に作っていってそこからモジュールに適宜分けていくような "modulith" がいいんじゃないかとのことだった
  * また、Google や Facebook も社内で揉んでから OSS として公開してるわけだし早まった Open 化はせずに揉んでからオープンにしてもいいんじゃない？とも話していた
* Elements of dance music
  * Web Audio API を使って古き良き90'sの Acid Techno を作っていく
  * 前半に Web Audio の簡単な説明と、音がどうやって出てるかみたいな話があって後半は実際に Web Audio を使って Acid Techno をライブコーディング(もはやコンサート？)していくというような内容
  * 現代の楽譜は JS であり、ペンは Vim なのだ...(!)
  * JS のカンファレンスで Roland の TB-303, TR-808 の音を鳴らしてるのヤバかった
  * 明後日の Web Audio Hack Day にも参加するつもりなので楽しみ
  * Electron にも `AudioContext` あるので GUI のシンセサイザーが作れそうだとおもった
* Bio-inspired Frontend Engineering
  * 学生時代に化学をやってた人による ES6 で生命を語るセッション
* PM2
  * この辺のライブラリは PM2 で落ち着いたのかな？nodemon とかもあるけど
  * デプロイ後のサーバでのなんやかんやを解決するために PM2 を開発したとのこと
  * PM2 はあまり触ったことがなかったが、CLI もしっかりしているようだし、plugin のようなものをいれれば Web のインターフェイスができたりもするみたいなので便利そうだった
  * また、最近こういうツールの定番の流れであるが、Web でメトリクスを見れる Keymetrics というサービスもやっているとのこと
* Simplicity through Functions
  * Functional Javascript のイントロダクションみたいなセッション
  * モロに Rich Hicky フォロワーという印象
  * 大半が Functional Javascript の話だったが、終盤に CSP と Transducers の話が出てきて結構面白かった
  * 即座には理解できなかったので調べてみたが、Function を組み合わせてそれを transducer とするような感じなんだろうか...(まだよくわかっていない)
* Towards Universal JavaScript
  * 少し前に isomorphic をやめて universal と呼ばないか論者が現れて論戦が行われていたが、universal 側の論客と思われる
  * 結局 isomorphic はサバクラでコードを共有することが主眼だが、universal は環境に依らないコードを書きましょうということらしい。発表でも分からなかったが、JS は実装によって挙動は変わらざるを得ないので真に universal というのは難しいんじゃないかとおもう...
  * React で　サーバサイドレンダリングするデモ
* Overboard.js - Where are we going with this?
  * JavaScript を取り巻く環境は日に日に過酷になっていて一見いいことのように見えるが、無限に情報をキャッチアップしていかなくてはならず、しかもその陳腐化も早いので生き残れるのは一部の人、ということになりかねない
  * ブログとかで新しいライブラリ/フレームワークが取り上げられてたりするけど、それプロダクションで使ってる？
  * メイの法則「ソフトウェアの効率は18カ月で半減し、ムーアの法則を相殺する」
  * 我々のオーディエンスは我々ほどウェブサービスやデバイスにお金をかけないことを自覚する
  * 開発者側の都合をお客に押し付けない(スピナーでロードするぐらいならサーバサイドで HTML 生成して返せや)
  * React は DOM の更新が遅いと喧伝しているが、DOM の更新は減って高速化できているかもしれないが、React 自体を読み込む時間や、React が実行する分のオーバーヘッドを考えると結局何も変わっていないんじゃない？
  * ブラウザはとても賢いから上述の問題も実はそこまで大きな問題ではないのでは
  * フレームワークを採用することによって学習コストもかかるし、デベロッパの開発環境は整えないといけないし、採用も面倒になる
  * 上述の通り、開発者の都合でお客にコスト(ロード時間、実行時間etc)を押し付けてはいけない

## 全体的な感想

セッションの面白さでいうと、Web Audio のセッションが一番面白かった。また、もうちょい Fuck yeah React や Fuck yeah Babel みたいな雰囲気かと思っていたが揺り戻しなのかフレームワークから距離を置こう勢が思ったよりいた印象だった。

また、Web Audio のセッションで html にアローを直書きしていて、トランスパイらなくてもいいのか？とおもったがアローはもうブラウザでも大抵動くみたいだし、無理にバベらずとも使える範囲で ES2015 のシンタックスを使っていけばいいんだなという実感が湧いた。MS Edge ならもう大抵のシンタックスは使えるので Edge いいなーとも思ったり。

Microsoft は本イベントをスポンサーしていたり、スピーカーがきてたり、昨日は VS code が OSS 化されたし勢いを改めて感じた。

以下メモ直貼り。

---

# #perfmatters - Tools for Apache Cordova

@ryanjsalva

Cordova について

There is a general perception that apps built using HTML, CSS, and JavaScript are slow

Interaction classes
fluid -> instantaneous -> Fast -> Upper bound on what users will consider responsive
~17ms    ~100ms           ~250ms  ...

Methodology
We identified SIX areas where developers commonly encounter performance issues. To identify these problem areas:

* Nexus 7 2013 (Android)
* iPad Mini 3 (iOS)
* Lumia 928 (WP)

1. The webview tax
2. document object model
3. images
4. animation
5. garbage collection
6. UI controls

(4, 6以外を話す)

Cordova はネイテイブってわけではないので Tax を払っている

memory consumption
native app: iOS > Android > WP > WS
browser: android > iOS > WP > WS
cordova: WS > iOS > WP > Andoid(huge)

startup time
iOS cold が時間かかる
warm はどれもぼちぼち(1-3secぐらい)

device capabilities にアクセスするために XHR 使うのでそれも Tax

Time of data transfer with plugin
WP はネイテイブに js が走るので気にしなくて大丈夫
他はほぼ線形に増える

DOM

bad

```
<ul>
  <li>
    <a href="...">...</a>
  </li>
</ul>
```

good

```
<li onclick="...">,,,</li>
```

layout thrashing

read/change はキャッシュするなどして毎回ループを回したりしないように

fast list virtualized

list を仮想化してメモリ効率を良くしてチラつきもなくす

FW 使うのもよし

images

gradients

bad
css の gradient を使う

good
gradient.png を用意してそれを使う(マジか...)

gabage collection

使わなくなった event listener は捨てよう！

element 毎に event handler 作るよりも 1つの event handler で受ける
もしくは親で受けて `currentTarget` をとる

Memory leaks

`var` はちゃんと付けような！

# Web based 3D camera simulator for Perceptual Computing

@princi_ya

Perceptual Computing => 理解するコンピュータみたいな感じ...?
コンピュータが周りで何が起きてるかを感知する

3D カメラで AR する

AR
現実世界を拡張する

Motion sensing input devices
* intel realsense
* leap motion
* kinect

Motivation behind this idea
JSのSDKがある

The SECRET
WSも使っているぽい...?

Websocket
full-duplex communication channels over a single TCP connection

Websocket も `new Websocket` するだけでよくなったし便利になったもんだ...

LeapMotion から ArrayBuffer で受け取ってゴニョる

# Gameprogramming in Javascript

Thai Typing Game

タイは LINE 使ってる人多いのかな

Thai Keyboard やばい
キーが4段x2

Lives in Bangkok
Write Go for Digital Ocean
Server side developer
Book on Go: Microservices in Go

Gaming
WoW
タイNo.1ゲーム: ねこあつめ(マジか)
日本語しかUIないのにメチャ流行ってる

What is serious gaming?
education for learning

Gamification
ゲーミフィケーションはモチベートとしていいよね

Why Javascript

CreateJS

gulp watch + browser-sync

RequireJS

spritesheets
フレーム毎にスプライトを作る

parallax scrolling

creating

scene creation / transition

cordova

Fix native keyboard, better background sound

Electron

Conclusion
Make games for learning
Writing games in Javascript is easy
Avoid cross platform tools if possible

# Modular vs Monolith

@timoxley

Nodesourceの人

Node.js: Culture of extreme modularity

me in 2012: Avoid frameworks

Building a library
reusable, more robust, higher quality code...

me in 2012: library-first development

me in 2015: yes but, there are some major caveats

rabbit holes everywhere

libraries are a lot of work

nothing for free

most of the time: yagni

what problem am i trying to solve?
is this the simplest thing that will work?

avoid premature modularisation
早まったモジュール化は避ける

statement
function
file
folder
internal package
external package(bad default)

上から下にかけてオーバーヘッドが大きくなっていく

assume your first attempt will be bad
最初の取り組みはクソだと自覚する

code retreat
撤退の規定？

don't get precious about your code
コードは貴重ではない（？）

over-engineering: the adding of unnecessary complexity

complexity kills projects
セキュリティの問題とか、複雑さが増すと死ぬ

over-engineering is more common than under-engineering
over-engineering is more costly than under-engineering

the wrong structure can be more costly than no structure at all

defer decisions

draw in pencil before you draw in ink

abstractions decrease local complexity while increasing global complexity
抽象化はローカルの複雑性を緩和するが、グローバルの複雑性を増す

building the wrong thing for the right reasons
間違ったものは正しい理由によって作られる

build the simplest thing that works

flat is better than nested
at the statement level: avoid nested if/else
...

the sweetspot is middle
A modulith?

avoid premature modularisation

monolith first

open source later
Google や FB は社内で揉んでから公開している

less abandonware
放置をしない

# Elements of dance music

What is music?
My simple...

Music = Rhythm + Melody + Timbre

This talk focus for timbre

Acid what?
Chicago & detroit, 1990

Roland TB-303
Bass シンセサイザー

Roland TR-808
ドラムマシン

Why acid techno
sounds good
simple to code

```
var ac = new AudioContext
```

Web Audio API 101

AudioContext
OscillatorNode
AudioParam(freq, det)

Basic waveforms
sin, パルス...

Volume enveloppes

Pitch and gain enveloppes: simple kick

Detuned sawtooth: bring in the bass

A brief excursion to the frequency domain

Filtering the bass
HPF, LPF

Noise for maracas

Cheating for the clap
ファイルから読み込み

ライブコーディング

# Bio-inspired Frontend Engineering

@gsklee
KKBOX

chemistry & molecular biology(academic years)

Astronomical vs atomic scale
filaments of our universe
end-stage red giant

We are all starchildren

Why we are here
convey ideas and thinking processes

ES6 で生命を定義するぞい

バベるぞい

ES2015 classes are designed to be maximally minimal
are still prototypical
constructor
unburden the function keyword
better for static analysis and readability
appear at exactrly where the next level of language abstraction...

technology be itself has no good or bad
it's the intent that matters

Fragile base class problem
global "CASCADING" style sheets, sass @extend, angularjs $scope

css modules, cssmodules class composition, react props

Long and haky inheritance chain bye!

mixins & traits?

React の lifecycle は細胞の lifecycle とも...みたいな話っぽい(よく分からない)

http://slides.com/gsklee/bio-inspired-frontend-engineering/

# PM2

PM2 の Author
keymetrics の CEO/Founder

My app is ready now what?

デプロイ後の問題を解決するために PM2 を開発した

Structured application & workflow

resources management and optimization
extend capabilities

86th most popular JS project

http://stats.js.org/

pm2 のインストールとか

他の言語のアプリケーション動かしたりとか

cluster-mode

reload, graceful reload, scale

inspecting applications

`pm2 list` list processes

`pm2 show <app-name|id>` more infomation

microservices args are ugly => json でコンフィグ書けるよ〜

deployment system
json で定義したりとか

modules

pm2 のプラグイン？みたいなのをインストールできる

pm2-webshell => ブラウザデシェルが叩ける(tty.js経由)

monitoring with keymetrics
https://keymetrics.io/

# Simplicity through Functions

NZ
SMX

Limits
we can only consider a few things at a time

reliability
simplicity vs complexity
easy vs hard
functional programming style
javascript code examples

1. terminology

reliability

adj "able to be trusted"

on time, controlled costs, able to change, correctness, quality, performance

simplicity is prerequisite for reliability

simple => sim plex
complex => com plex

simple
one braid or fold
one role, one task, one concept, one dimension

complex
braided or folded together

ease < aise < adjacens

lie near
not difficult, requiring no great labor or effort

Simple != Easy

limits
we can only hope to make reliable those things we understand
we can only consider a few things at a time
intertwined/braided things must be considered together
...

construct/artefact
for developer / for users

complect
to interleave, intertwine, braid
don't do it

Functional programming
no single definition
some features readily available in Javascript
some features require care or libraries or helpers in Javascript
...

difference between OOP vs FP

2. Functional Javascript

values `42`, `"hello"` => simple
`40 + 2 //42`, `"hello" + "world" // hello world` => simple
identity => simple
state => complex
const => simple
maps => simple
mutable maps => complex
immutable collection(immutable.js) => simple

why immutability?
most complexity comes from tracking mutation and maintaining state
...

loops

branching => complex
recursion
recursion with TCO

impuew funcrion

map => simple
reduce => simple
filter => simple
forEach => complex

OOP / methods etc.

namespaces functions values => simple
curry

event handlers

communicating sequential processes
CSP

transducers

```
Immutable.fromJS(
  seq(
    Immutable.Vector(1, 2, 3, 4, 5),
    compose(
      map((x) => x + 10)
      filter((x) => x % 2)
    )
  )
)
```

```
const c = chan(map((x) => x + 10), filter((x) => x % 2))
```

simplicity is not an objective in art
...

# Towards Universal JavaScript

http://slides.com/sarmadsangi/towards-universal-javascript

1. what? why universal javascript?
2. how to build a universal javascript

Sarmad Sangi
RedMart

what is universal javascript

universal
javascript code which is environment agnostic

isomorphic
that any given line of code (with notable exceptions) can execute both on the client and server

isomorphicと違って環境に依らない

SEO
Performance
Mainttainability

SEO
How bots see our javascript applications
UAでbotだったらPhantomJSで描画したものを返す

Universal javascript では JS でレンダリングしたものを返す(?)

Maintainability
Shared logic between server and clients

How to build a universal javascript

# Overboard.js - Where are we going with this?

@codepo8

Unobtrusive Javascript

MS Edge の人

Authoring web sites and enhancing them with JS
Scripting/Extending applications(Illustrator, Homesite, VS code, Sublime...)
Authoring re-usable widgets for people who don't know JS
Working on libraries/frameworks
Working on Browsers and JS engines
Working on server-side Javascript
Designing APIs for JS consumption

Javascript is a versatile, creative...

we keep treating js like a one size fits all environment we can control

lately we go overboad with js

we're going full speed on innovation
componentised web
modules/packages
extensible web manifesto
web assembly/asm.js
postcss
progressive apps

the vicious innovations cycle

we force ules onto ourselves that might be overkill

we live in a hype fuelled environment
新しいライブラリを記事にしたりするけどプロダクションで使ってなくない？

Moore's Law

we work with amazing hardware

we work with great connectivity

we get paid well - for a job we like

we work with amazing browsers

May's law

we move fast and run in circles

the web is in a sorry state
the median page's time to interact is 5.5 secs, and fully loads in just over 15secs
the median page is 2MB in size and contains 170 resources

waiting isn't fun

オレたちのオーディエンスはオレたちほどウェブサービスに金をかけることや、アップグレードすることに興味がない

growth happens where moore's law isn't a reality(asia)

moore's law stopped working when we hard-wired hardware and software

as developers, we are asked to do the impossible
make it work the same in every browser
make it easy to maintain and we want to control everything
make sure it is also accesible
don't spent too much time on it, let's release it now and fix it later
use this analytics code you have no clue about...

今日のすごいものは明日には死んでるかも

a simpe way to detect how old a part of our massive site is checking which version of jQuery was used in that part of it

we break the web for the sake of developer convenience

The cost of frameworks

the dom is slow?

time in framework | dom manipulation

vanilla vs react

バニラだと写真が増えても時間が増えない(むしろ減る)がreactは上がり続ける

browser do an incredible amount of work for us
display of all kind of media content
fix minor mistakes in our code
optimise our code to run smoothly
provide us with developer tools
provide us with deep insights what our code does to the computer
allow us to automate testing in them and debug remotely on devices we don't even own

big-rig

framework は bootstrap に時間がかかる

fixing everything with a lot of javascript help us, not necessarily our audience

cost for developers
learning new frameworks
re-learning frameworks
debugging frameworks
setting up developer environments
cutting down on possible hires/adding to onboading time

the real important bit is the cost for our users
...

the javascript learning process has always been interesting

JS を学習するのはつらい(Stack overflow見たりとか...最後はIEに殺意を覚える)

ES6

controlled environments allow us to use the newest and coolest and find best practices

let's not make the javascript world overly complex and scary

ES* caters to different audiences

babel の Lean ES2015はいい

let's turn competition into education and fun again
