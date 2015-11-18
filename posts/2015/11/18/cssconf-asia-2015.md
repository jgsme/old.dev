# [CSSConf.asia 2015 メモと感想](/2015/11/18/cssconf-asia-2015.html)

会社に支援いただいて Devfest.asia に参加できたのでメモと感想をば。

* 3.14 things I didn't know about CSS
  * CSS の tips を中心に CSS での XSS など
  * Attribute value を使って csrf token を盗んだり、Web font を使って個人情報を盗んだりできるというのが新鮮だった
  * あと CSS Expression も初めて知った(知らない方が幸せだった)がまさに evil という感じで最悪
  * 最後に CSS セレクタでバンド名を表現する芸をやってたのが面白かった

```css
p, i {
  color: black;
}

/* Black <i>'d <p>s */
```

* In the Year 2000 - Designing responsive emails
  * HTML と CSS でデザインされたページを作り上げるのがいかに困難かという話
  * メールクライアントはまさに地獄という感じで、Outlook の特定のバージョンは Word でレンダリングされたりするそうで恐怖でしかなかった, Gmail(webkit)も信用ならないとのこと
  * また、画像が読み込まれないことも多々あるので、`alt` をちゃんと付ける話とか涙なくては語れぬという感じ
  * そして、そういう環境下ではテーブルレイアウトが現役という話もまた厳しかった
  * ちょくちょく綺麗なメールがくるけど(Vimeoとか)あの陰には犠牲者がいるのだな...と気付かされた
* Moneyball for performance Metrics
  * ブラッド・ピット主演で映画化された Moneyball で描かれていたように Metrics をとるのが大事という話と、いかに必要となる Metrics をとるかという話
  * ちょいちょい聞いたことのある速度改善で KPI 改善したよみたいな話
  * 通信を HAR で計測したりとか、`performance` でレンダリングを計測したりとか
  * http/2 の話はさらっとという感じ
* Animating SVGs
  * みんな大好き SVG のアニメーションの話。自分もここ半年ぐらいだいぶ SVG に取り組んでいるので謎の親近感があった
  * なぜ SVG かというと、大概のブラウザでサポートされているし、CSS でスタイル当てられるし、スケーラブル(解像度的な意味で)だから。ひたすら頷くオレ
  * その SVG をアニメーションさせるためには 3 通りあって、CSS、SMIL、JS
  * SMIL というのが初見だったが、XML の要素として `<animation from="0 0" to="100 100">` みたいな感じで書くとアニメーションできるらしい
  * ただ、IE や Opera (今では Webkit に変わったから実装されてるのかなあ？)ではサポートされてないし微妙っぽい
  * やっぱり JS で制御するのがややこしいアニメーションも制御できるしよさそうだった
  * Shape morphing をやるときや、適当なインターフェイスがほしいときはライブラリを使うといいぽい
* PostCSS - aka how to sneak JS into a CSSConf
  * 今回のセッションの本丸ぐらいの気でいたが、PostCSS の紹介で終わった
  * とはいえ、このあとズラズラと Module CSS ボーイズが語ってくれてたのでちょうどよかったかも？
  * PostCSS はパーサで、200を超える plugin 群がそれらを加工する
  * PreCSS を使えば mixin や制御構文や変数を使えるので Sass とオサラバできる
  * パフォーマンスも上々
* The End of Global CSS
  * タイトルの示す通り、Global な CSS を捨ててコンポーネント単位で CSS 書こう屋
  * Component って実は新しい概念ではなくて、我々が今まで使ってきていた `<select>` やら `<button>` もコンポーネントと見立てることができる
  * これまでもサードパーティ製のコンポーネント(例えば jQuery UI Date picker)を使ってきたが、画像リソースやら js やらなんやらてんこ盛りだった
  * それらのために gulp とかを使ってたけどさ...
  * Component 時代のツールは Webpack で落ち着いたみたい, JS 屋の自分からしてみると browserify と適材適所という感覚だが、CSS マン達的には Webpack で FA という雰囲気を感じた
  * Components みたいな名前のディレクトリにコンポーネント毎にディレクトリを切って必要なリソースを格納していくスタイル
  * その時に名前空間をどうするか、ということで local scope を使うらしい
  * `:local(.class)` みたいな感じでセレクタを書くと、ユニークなハッシュを生成して、そのハッシュを JS で参照するというスタイルのようだ
  * local scope は Webpack の css-loader で使えるが、PostCSS にも plugin がある模様
  * また、`composes` というプロパティを使うことで他の css ファイルからプロパティを呼んできて結合したりもできるそう
  * 恐らく React をメインターゲットに据えてるとはおもうが、Mercury や Angular でも使えるし、Vanilla でも使えるとのこと
  * JS のランタイムはなし(Webpack の分はあるんじゃないかとおもうが)
  * これらが CSS Modules として切り出されていろいろ実装が作られているようだ
* The Rise of Modular Style
  * 前のセッションに続いて、CSS Module 勢
  * JS の歴史の話があって、CommonJS で module を export/import できるようになったのが最高で、これを CSS に持ってきたいという話(何周遅れの話なんだ...)
  * それが Interoperable CSS https://github.com/css-modules/icss
  * CommonJS よろしく export と import の構文を持っててこれらでモジュール化された CSS を参照するような構造に
  * HTML の class に `class="button button-success"` って書くのアホらしくない？って話がなるほど、とおもった
  * Sass の mixin 使ってもいいけど生成される CSS セレクタが鬼のようにデカくなるので Webpack の composes 使おうねという話
  * Future work として CSS on npm という話があって、これはブラウザ界もパッケージとして管理する意向の npm inc. と似た方向の話なんだろうとおもった
* Performance beyond Page load
  * ページのレンダリングを改善する話
  * パフォーマンス向上のインパクトとしては
    * Layout > Paint > Composite らしい
  * これらは http://csstriggers.com/ を見ると CSS のプロパティがそれぞれ上の 3 つのうちどれが発火するかひと目で確認できる。これを使って不要なプロパティを消したりして改善していくぞ
  * それに当たって Chrome dev tools の FPS meter や paint flashing は便利
  * その他 `nth-last-child(-n+1)` みたいなセレクタはやめて class や id で参照するだとか、不要な CSS を削るとか、再計算コストを計測するとか
  * これまで GPU を使うために `transform: translate3d(0, 0, 0);` みたいなことをしてきたが、これからは `will-change` プロパティを使って再計算(主にアニメーションかなあ)コストを最適化できるらしい。https://dev.opera.com/articles/ja/css-will-change-property/ が詳しかった
  * http://perfaudit.com/ にいろんなサイトの最適化例が載ってる
* Responsive Web Bloopers
  * Viki https://www.viki.jp/ という動画サービスの中の人
    * 余談だが、i11n もしっかりしてるし国内の TV ドラマもあるし結構いいサービスなのでは
  * Viki を改善していくに当たってぶつかったこととその解決
  * その1: デザイナとデベロッパの交流が乏しい
  * デザイナが張り切って Web で全く作れる気がしないアニメーションを作っちゃったり、巨大な画像をいれちゃってたり、複雑なレイアウトで作業を終える
  * デベロッパが作業を開始すると問題だらけでデザイナに突き返したりとかを繰り返してクソの山を積み上げていく
  * そしてベータテスト後に巨大なリファクタをしてようやくリリースに漕ぎ着ける、的な
  * これを次のように改善した。デザイナはラフの時点ぐらいからデベロッパに渡してしまって、デベロッパはそれを元に(醜くてもいい)プロトタイプを作成する。このプロトタイプを元にデザイナがデザインを詰めて、デベロッパがそれを実装して...というのを繰り返す
    * 小さいイテレーションを回すのは僕も経験的に全く同意で、今の仕事ではデザイナではビズの方とやり取りすることが多いのでビズの方のふわっとした話を最初は細かく詰めてから作業に取り掛かっていたが、さっさとプロトタイプを作ってしまってそれのフィードバックをもらって修正した方が手っ取り早いということに気付いてからはそうするようにしている
  * その2: 開発計画が乏しい
  * コーディングスタイルや、フレームワークが全然決まっていなかった, この辺は整備したらしい
  * その3: 実機でデバッグするのが遅かった
  * 実機でデバッグするのが開発の最終段階で、それまではシミュレータでしかサイトを確認していないと痛い目に遭う
  * これも UI component を作成したら実機で早めに確認するサイクルを回した方がいい
  * ghostlab の話をしていたが、オレたちには browser-sync があるやん、と思って聞いてた
* Webfonts: Levelup
  * 最後のセッションは W3C の人
  * PNG の co-author だったり、CSS の仕様周りに携わっている人のようだ
  * Character と Glyph の違いから、フォントの未来まで
  * CSS3 の Font Module から紹介をしていた
  * Font あまり詳しくないのでアレだが、カーニングなど CSS で指定できるみたい
  * Javascript で `new FontFace(...)` とすることで Font を読み込むことができるらしい
  * TransType というフォントのデモをしていたんだけど、よく分からず...文字毎にパーツを組み合わせてパーツ毎に色を変えたりとかもできるみたい

## 全体的な感想

JS マンとしては全てを JS の支配下に置きたい主義なのだが、CSS マンたちは CSS 独力でなんとかしようとしている(といっても Webpack などが JS を隠蔽しているだけだとおもうが)印象があって少し相容れなそうだった。

面白かったのは Viki の人のセッションで「デザイナがレスポンシブデザインのモックを作ってきたら、小型のデバイスでカラムの順番が互い違いで作ってくる」みたいな話をしてたりして思わず「あるある〜〜〜〜」ってなってしまった。

その他、パフォーマンスや XSS の話もあり、興味深かった。

明日と明後日は JSConf!

以下メモ直貼り。

---

# 3.14 things I didn't know about CSS

@mathias
Operaの人

`!important`よくないよね

->

```
.foo .bar {
  color: red;
}

.bar .bar {
  color: green;
}
```

が `!important` と同じ効果がある

Font famiy names in CSS
Whitespace in the font family name, it must be quoted <- NO

`\34 56bereastreet`

Attribute values

```
a[href=foo] {
  background...
}
```

unquoted attribute values

```
a[href="foo|bar"] {
  background...
}
```

CSS comments

```
.some {
  /* comment */
}
```

single line comment もいけるらしい

```
.some {
  // comment
}
```

HTML tags

* head, bodyは閉じタグなくてもいい
* head, bodyはそもそもなくてもいい

Using CSS without HTML

HTMLなくてもゲームみたいなやつがつくれる

Unicode in CSS

Unicodeの文字ならclassやidに使える...が、CSSではエスケープが必要

`#\#id { }`, `#\34 04-error`, `.\[attr\=\'value\'\]`

Escaping CSS selectors

`CSS.escape`

XSS

CSS Zen garden

evil.css

attribute valueを使ってcsrf tokenを盗める

Webfontを使ってDOMの情報を盗める

CSS Expressions in IE 7-
CSSにJSのコードを書けるやつ
IE7までだけど、legacy modeでIE7 modeにするとIE10でも使える

* CSSにinjectするときもちゃんとサニタイズする
* `X-Frame-Options: DENY`
* use `<!DOCTYPE html>`

Firefoxは `background: url(javascript:while(1){})` で殺せる

# In the Year 2000 - Designing responsive emails

http://jennz0r.github.io/2000

Emails are evil

design
code
resources

hotpads.com

minimum touchable areaの44x44はiPhoneのガイドラインなので

Emailではtable layoutが最高

`<style>`や`<head>`をサポートしてないのでinline styleでがんばる

max-widthは500-600程度

画像は表示されないことを考慮してaltやfallbackのstyleをつけるなどする

media query

device pixel ratio

`!important` をmedia queryで使う

OutlookはWordでレンダリングしてたりしてつらい
webkitといえどもいろいろサポートされてなくてつらい

# Moneyball for performance Metrics

npmの人

Moneyball の話を参考にチューニングする

slow websites lose

The state of Javascript on Android is very poor

結構な人がMobile deviceがprimary device

people exepts mobile fast

2G than 4G

パフォーマンスを上げることでconversion, revenueを改善できる(walmart, obama for america)

改善するにはまず計測から

DOM complete, Load

page weight

request/response: new relic, calibre, skylight

focus first usable time

webpagetest

render blocking

find the files that block

PhantomJS

HAR file

round trips

TCP slow start

timing differences

`performance.timing`

different websites need different measurements

UserTiming API

`performance.{mark|measure}`

latency

server-side rendering

best practice

concatenate, minification

The Future is now

performance budget

http/2

# Animating SVGs

https://github.com/zellwk/CSSConf.Asia-animating-svg

Zellさん

Good browser support, styleable, scalable

animation methods
* CSS
* SMIL
* JS

targeting SVGs(query selector)

transition...

SMIL

* IE, Operaのサポートがいらないとき
* シンプルなアニメーション

`<animate>` の属性にアニメーションの設定を書いていく

javascript

complex animations
support all browsers

vivusJS
snap.svg
morphSVG

shape morphing

# PostCSS - aka how to sneak JS into a CSSConf

@lcpriest

Ruby and EmberJS

TradeGecko

PostCSS is not preprocessor

PostCSS is just a Parser

Modify Declarations, Modify Rules, Modify Comments

Plugins

200+

PreCSS

Goodbye Sass

RTLCSS https://github.com/MohammadYounes/rtlcss

Discourse: Rails + EmberJS

アラビック向けに左右を反転させる

postcss-imperial
postcss-singlish

# The End of Global CSS

Documents vs Web apps

Global Scope vs Maintenance

OOCSS, SMACSS, BEM, SUIT...

CSS at scale feels
Completely Different

How do we scale interfaces better?

The Age of Components

Web components, Polymer, Angular's directives

REACT!!

Components are nothing new

CSS and images are private to a component

Unless you use third-party components

jQuery UI date picker(sucks)

gulp, sass

tooling for the component age?

webpack

single dependency tree
components 下に component 毎に dir を切る

BEM

a block is a component

Block, Element, Modifying Your Javascript components

(webpack) local scope

what does styles eval to?

`:local` scope

`styles.header` みたいな感じで component からアクセスできる

`:local`は hash の unique に変換されて hashmap で参照

no more naming collisions

loader の設定で参照の名前を変えられる

`:local(.header)` みたいな感じでもアクセスできるみたい

PostCSS

postcss-local-scope

webpack composition

css を結合できる

```
.some {
  compose: className from "./style.css";
}
```

React, Mercury, Angular, Backbone, VanillaJS

Javascript dependency => No

The future

CSS modules

# The Rise of Modular Style

Human interfaces vs Machine interfaces

September 2008, Attack from IE
JavaScript in 2008, windowにnamespaceを生やしてなんとかする
V8: Sept 2, 2008

ServerJS

NodeJS: Feb 2009

CommonJS: July 2009

namespace vs commonjs

Browserify: Sep 5, 2011

CSS - Sass, Less, PostCSS

Interoperable CSS: June 21, 2015

ICSS

```
:import("./some.scc") {
  import-alias: some-depend;
}

:export {
  normal: ...
}
```

同名クラスだとしても hash が変わるので名前が衝突しない

CSS Modules

EmojiのクラスでhtmlとCSSを書く
もろもろツールを使ってヒューマン、マシン共にリーダブルにしようという話

Modular Style

`.button .button-success` みたいなのはダサい

sassで継承させるのはいいけど...生成されるCSSがクソデカくなる
なんで webpack compose 使おう

Atomic design
Atoms, Molecules, Organisms, Templates, Pages => all component

Future work
* Reusable components w/ CSS on npm
* Non-JS ecosystems

# Performance beyond Page load

Javascript style layout paint composite

performance impact of operations:
layout > paint > composite

Chrome Dev Tools: FPS meter, paint flashing

CPU vs GPU

http://csstriggers.com/

must follow
understand what impacts rendering performance (Profile)
choose your css rules wisely
avoid triggering layout / paint operation repeatedly or when animating
prefer using transform add opacity changers (trigger only composite operation) for animations

`nth-last-child(-n+1)` less performant

remove unused css rules

reduce number of elements being styled

measure your style recalculation cost

debounce input handlers

fixed elements and scrollable elements are repainted by the browsers

```
transform: translateZ(0);
```

GIFs and performance

disable animation when not inside the viewport

```
will-change: transform;
```

will-change: https://dev.opera.com/articles/ja/css-will-change-property/

http://perfaudit.com/

# Responsive Web Bloopers

@renettarenula

viki の人 https://www.viki.jp/

Working together, writing code, testing site

Lack of collaboration between designers and developers
(デザイナとデベロッパの交流が乏しい)

designer limitations:
Fancy animations
Big images
Beautiful, intricate layouts

Mockups
Performance, Interaction type(small => touch, large => mouse)?

developer shortcomings
Discovered problems late, hasks, shortcuts, library...

previous workflow
design mocks -> test validate -> develop and test -> beta test -> big fixes -> rollout

collaborative workflow
low fidelity mockups/sketches -> prototype -> feedback -> high fidelity design mockups

prototype
not necessary to prototype everything
build fast, build ugly

writing code
lack of planning on development
(開発計画が乏しい)

coding style guides
naming conventions, file organizations, nesting levels, media queries
BEM, OOCSS, SMACSS

beware of frameworks
CSS bloats, Rigid styling, unsuitable frameworks

browser and device issues
target browsers and devices, design within constraints, device specific issues

Testing site
testing late on devices and relying too mush on emulators

device testing
testing interactions, bugs and quirks on mobile

experia のバグ

better workflow
build a UI component -> connect local env to device -> repeat ->

localtunnel, proxylocal
ghostlab

# Webfonts: Levelup

https://github.com/svgeesus/font-level-up

Co-authored PNG
CSS WG: Chair, CSS2 co-editor, CSS3 Color co-editor

* Basics
* OpenType features and CSS
* Performance
* The future

Character
a codepoint, with properties

Glyph
visual representation of characters

Myriad Pro <- Font family
Light Roman Bold Italic <- faces

`@font-face` はデスクリプタ、セレクタはプロパティ

descriptors
descripbe individual font faces

properties
requests for styling

Font stacks
First font with glyphs for a given character is used
Problem: avoiding bad Latin glyphs in Japanese fonts

unicode-range
descriptor afor allowed range of unicode characters

unicode-range is really shit

OpenType features
optional stylistic controls

Control with CSS
fonts vary in features

font-variant
preferrerd, but poor support

font-feature-settings
cryptic, low-leve, widespread support

```
font-variant-numeric: proportinal-nums;
```

分数とかも出せるぞ！

```
font-synthesis: weight style;
```

```
font-kerning: none;
```

Performance

http://www.fontsquirrel.com/
https://typekit.com/
https://github.com/behdad/fonttools/

WOFF compression
adds header, metadata
gzips each table

WOFF2 compression
excellent font-specific compression
WOFF1よりベターらしい

CSS font loading API
FF, Chrome, Opera, Android

```
new FontFace()
```

The future

From illuminated manuscripts
...to emoji

TransType

svg

CSS4 font-palette
CSS4 font-synthesis

emoji, math, fangsong
svgeesus
