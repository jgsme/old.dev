# 激ヤバ鬼便利日報ツールを Go でリプレースした
https://github.com/e-jigsaw/journal

弊社には日報をメールで送る文化があって(それの如何についてはともかく)、意外と読まれるようなので力入れて書いた方がいろいろな場面でよさそうとのことなのでここ一週間ぐらい日報をいかに楽して書くかに全力を投じてきた。一旦は git の pre-commit hook を使ってメールを送信する「激ヤバ鬼便利日報システム」で落ち着いていた。pre-commit hook は coffee-script で書いていたので coffee が入ってないと使えない欠点があるので布教しやすい何かにリプレースすることを模索していた。

そこに、先日になって急に Go の熱が燃え上がって Go をはじめたので Go でリプレースすることにした。A tour of Go を途中までやった程度の Go力なので、Go をやるきっかけになった ghq(https://github.com/motemen/ghq) などを参考につくった。

Go は CLI ツールとの相性がとてもよくて、Go がインストールされていれば

```
% go get github.com/e-jigsaw/journal
```

するだけでコマンドが使えるようになるし、gox (https://github.com/mitchellh/gox) を使えばクロスコンパイルも容易で、他プラットフォームのバイナリもスッと吐けるのであとは github に release をつくるだけでよかった。あと https://speakerdeck.com/tcnksm/fu-shu-puratutohuomunigoyan-yu-falseturuwopei-bu-suru-number-hikarie-go　も参考に homebrew の formura もはじめてつくった(https://github.com/e-jigsaw/homebrew-journal)。

```
% brew tap e-jigsaw/journal
% brew install journal
```

で homebrew からのインストールもできるようにした。使い方とかは github の README を参照してほしい。

余談だけど、`alias j='journal'` にすると `j c` とか `j s` みたいなコマンドになることに気付いたのでいっそ

```
alias jk='journal write'
alias jc='journal comment'
alias js='journal send'
```

にしてしまうと、日報をつける度にちょっとムフフな気持ちになれる、いや、なれないか。

あと、最近話題の Wercker も試しているところで、Go のテストの作法を学んで CI していきたい。
