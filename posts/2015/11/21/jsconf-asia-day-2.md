# [JSConf.asia 2日目 メモと感想](/2015/11/21/jsconf-asia-day-2.html)

昨日に引き続いて2日目。

* Making realtime Audio-Visuals
  * Canvas と Web Audio を使ってオーディオビジュアル作品をライブコーディングするといった内容
  * 普段からゴルフやってて、作品のデモもあった
  * JS ではちょいちょいトラップがあるのでその避け方の話など
  * http://www.p01.org/jsconf_asia_2015/live.htm というのが最終的に完成した
  * 他のセッションでもあったが、ゴルファー気質な人たちは HTML に `style` と `canvas` と `script` だけを書いてページを作っているのが印象的だった
* Node.js Authentication and Data security
  * Node.js でのセキュリティと認証の話
  * 2014年の流行パスワードランキングは相変わらず「12345や、qwerty、password、baseball、dragon」など
  * アシュレイ・マディソンから流出したパスワードの中には「thebestpasswordever」というクソパスワードもあったそうだ
  * また、2014年の OWASP (セキュリティ系の団体っぽい？)発表の脆弱性ランキングも相変わらずインジェクションやら XSS、CSRF などなど
  * Node.js 絡みであるのは、正規表現で死んだり、`X-POWERED-BY` に `express` が入っているなど
  * `helmet` や `lusca` などで事前に防ぎましょうね、という話
  * それから、そもそもパスワードで認証するのをやめようという話もあった
* Electroknit!
  * Node.js で編み物をしようとおもったらなぜか画像処理までいってしまった話
  * 東京 Node 学園祭でも発表があったので割愛
* Javascript Security
  * 前の前の発表に続いて JS 絡みのセキュリティの話
  * 実際に簡単なブログでいろいろ盗みとるのをデモしたりしていた
* I Play the JavaScript
  * Abelton Live に JS から仮想 MIDI ポートを接続して演奏するデモ
  * Abelton Live を操作してるのはどちらかというとペイントに近くて、演奏しているわけではないので外部デバイスを使って演奏したい
  * だが外部デバイスを操作するのは難しいのでプログラムで補正したり、補助したりしたい
  * npm の midi-stream という midi を stream で受け取れるライブラリで情報をとってきて、バーチャル MIDI ポートから出力できるライブラリを使う
  * observ で値を監視&加工して MIDI に戻す
  * この辺をパッケージングして Electron に載っけたのが http://loopjs.com/
* Unbox Development in Production
  * 開発に Docker や Vagrant を使おうねという話
  * Docker と Vagrant の比較、デモなど
* The route to HTTP/2
  * HTTP の歴史から、HTTP/2 の概要
  * 面白かったのは99年と15年の間で Apple と Yahoo は結構デザインが変わった(といっても大まかなレイアウトはどちらも変わってなかったりする)が、Google はロゴしか変わってなかったという話
  * concatnate は微妙だし早く HTTP/2 にしようや(といっても HTTP/2 は2で大変そうとは思うが...)
* Reactive JavaScript at Netflix, Microsoft and the World
  * RxJS 界からの刺客
  * 主に Netflix でどう Reactive 化していったかという話
  * ちなみに、Netflix はアメリカのトラフィックのうち 1/3 を占めているんだそうだ。すごい。
  * Netflix はそのサービスの性質上サバクラ問わずいたるところに非同期処理がある
  * 非同期処理の悪夢
    * メモリリーク
    * レースコンディション
    * コールバックヘル
    * 状態遷移の複雑化
    * エラーハンドリング
  * 2011年からこの問題に取り組んでいた
  * Event も Steam 1,2,3(Node.js) もクソ
  * デザインパターンの Observer, Iterator に着目した
  * Events や Arrays をコレクションとして扱う
  * ここでいう Observer は `Object.observe` (RIP) でもないし `EventEmitter` でもない
  * リアクティブプログラミングとは: http://bit.ly/reactive-paper
  * Observer にはその性質上バックプレッシャーがあるが、RxJS には Hot/Cold の仕組みであったり、`debounce`, `pauseable` などの仕組みがある
  * ES2016 には `async/await` (Edge の実装がある)だったり、`subscribe/unsubscribe` (ES-Observable として Proposal がある)があるのでゆくゆくはもう少し使いやすくなるんじゃなかろうか
  * CSP との比較もあったが、Observe パターンの方が簡潔とのこと
* Meet the Node.js Foundation
  * Node Foundation から @DivaDanese
  * PayPal が Node.js にスイッチした話と、Java をオープン化しようとした動きの話、そして Node.js Foundation について
  * Node.js が Fork して現体制まで移行した話は有名
  * これを拡げる取り組みを Node.js の核とも言える libUV でやっているとのこと
  * オープンソースは人が大事なので、みんなも協力して、時には議論してやっていこうな！

以下メモ直貼り。

---

# Making realtime Audio-Visuals

@p01
Opera の人

1. what and where

code golfing and creative coding

demoscene

2. general tips

focus

no library, no framework

one primitive
one formula

3. wild tricks

dirty trigonometry

1 ≒ π / 3

IEEE 754

.2 + .1 = 0.30000000000004

`for(i = 0; i< 10; 1 += 1/8)`

music

Web Audio API or Audio element

regular 1k and 4k demos pre-generate the music

colors

`hsl(31, 33%, 73%)`

RGB だと `Math.cos` で計算せんといかんので

shadowblur

png bootstraping

4. coding time

デモ〜

`radial-gradient(circle, #345, #200)`

# Node.js Authentication and Data security

Braintree の人
@SeraAndroid

PayPal + Braintree since 2013

古代ギリシャのヘラクレス
セキュリティは Hydra に似ている

The human element

TOP 10 passwords 2014
12345
password
12345678
qwerty
baseball, dragon, football

honorary mention
superman, batman

authentication and authorization

OWASP top 10
1. Injection
2. Broken authentication
3. XSS
4. Direct object references
5. Application misconfigured
6. Sensitive data exposed
7. ACL
8. CSRF
9. Vulnerable code
10. Redirects / Forwards

Hashing
md5, sha1, sha2, sha3

アシュレイ・マディソンの流出クソパスワード集
thebestpasswordever

efficient hashing
crypt, scrypt, bcrypt, PBKDF2

Stalted hashing
algorithm(data + salt) = hash

use strict

regex
正規表現は結構な穴らしい

character encoding

X-POWERED-BY
余計な情報を開示している

node-uuid

http parameter pollution

bcrypt

a bcrypt generated hash

CSURF
form に CSRF token を仕込むやつ

helment
いろいろ攻撃を防げるやつ

lusca
同じくいろいろ攻撃を防げるやつ

passport

passwordless auth

owasp node goat

https://nodesecurity.io/

fast identity online

OpenID is DEAD

Something you have
Something you know
Something you are

Favor security too much over the experience and you'll make the website a pain to use
https://fidoalliance.org/

# Electroknit!

Node.js で編み物をしようとおもったらなぜか画像処理までいってしまった話

# Javascript Security

`window.name`

# I Play the JavaScript

NZ

Abelton Live っぽい

Painted, not played

A little bit internet famous
http://lunarmusic.net/album/hybrid-awaken

演奏してるわけではないので、どうやって演奏するか？

DJ it!

ハードのコントローラで制御

I want to feel like I'm playing an instrument

JavaScript to the rescure!

What is MIDI?
Musical Instrument Digital Interface

midi-stream

virtual midi port

midi で受けることもできるが、仮想 MIDI として出力もできる

observ

オブザーバで値を加工する

加工したやつを midi に戻す

observ-transform

テンポ

テンポに合わせてリピーターを作る

Recorder, loop

What about Web Audio?

audio-slot

budo

loopdrop

http://loopjs.com/

Rewrite constantly

# Unbox Development in Production

Have you encountered this

A new developer joins your team...
Then you spend your next couple of days setting up their tools, development...
バグが手元のマシンで再現しない

Docker
Vagrant

Docker と Vagrant の比較

# The route to HTTP/2

@chleozam
WHub.io

Hyper Text Transfer Protocol

91: v0.9
96: v1.0
99: v1.1
12: SPDY
15: HTTP/2

is not the web in 2015
apple と yahoo は99年の変わったけど google は変わってない

request up
latency adds up

http requests are expensive

http1.1 work-arounds

spriting
中の要素をひとつ変えただけでキャッシュが死ぬ

embed binary

concatenation
結合してると1行変えるだけで全体が変更される

sharding

duplicated data packets due to over shard

double facepalm

let's fix http instead

make a protocol that is less RTT sensitive
fix head of line blocking
stop the need for and desire to increase number of connections
keep existing interfaces, URI, format and schemes

IETF - Internet Engineering Task Force
SPDY
RFC May 2015

binary protocol

compact, efficient, much less error prones

header compression

HPACK, reduce oberhead, Gain 66%

Priorities
using weight/dependencies

server push
HTMLのリクエストを送ったら一緒にCSSも返してくれる

Multiplex
1つのTCPコネクションで複数のデータを送る

Recap

for normal humans: faster faster faster
for devs: separate tweaks to optimize, no more workarounds

you did not notice but, it's already there

# Reactive JavaScript at Netflix, Microsoft and the World

Reactive なプログラムのデモ

非同期処理を怖がらずに observe する

Microsoft

Thailproject

Reactive Extensions(Rx)

Netflix
Stream Movies From Any Device
1/3 of US Broadband Traffic

BIG async problems

Netflix App is async
App startup, player, data access, animations, view/model bind

async nightmares
memory leaks, race conditions, callback hell, complex state machines, disjointed error handling

2011-2014
いろんな言語でバックエンドもフロントエンドもエンジニアがいた

Real-Time is Everywhere

async programming is awful

events and the enemy of the state

First class async with promises

Promiseキャンセルできない問題

Stream processing

Streams1 were terrible
Streams2 Electric Boogaloo
Streams 33 1/11

Design pattern
observer, iterator

Events and arrays are both collections

map, filter, flatmap

everything is a stream

Observable not eq OO, EE

Reactive programming

React

What is Reactive Programming anyhow?

bit.ly/reactive-paper

FRP is...

Rx Grammer Police

Type ashead search

Rx concepts

Observables can have backpreshure

schedulers matter

async/await

Observables in ES2016
subscribe/unsbscribe

Future of RxJS

CSP vs Observables

CSP: 1978

Observable の方が簡潔に書ける

http://reactivex.io/

# Meet the Node.js Foundation

@DivaDanese

June 2014 foo camp

PayPal switched to Node 2013
Bill Scott

2014: Released Kraken

Gaining adoption

Passionate Ecosystem

Open Source canbe hard to understand

Java is not Open source

Java community process

Renegotiating the JSPA

Apache got Angry

Java の OSS 化にいろいろあった

Advisory Board - Oct 2014

プロセスに不満が溜まっていた

community fork - Dec 2014

Possibility of a Foundation?

NodeSummit Panel - June 2015

Organization Charted

オープンソースは人

Technical Steering Committee

Mission: Open development

Adjacent projects

Proposed first project: LibUV

Get involved
