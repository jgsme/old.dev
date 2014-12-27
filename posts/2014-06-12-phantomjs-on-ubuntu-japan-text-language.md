# phantomjs on ubuntu で日本語が文字化けする件

# TL;DR

* 日本語フォントいれろ
* locale を `en_US.UTF-8` にしろ

# 詳細

表題の通りで、まず ubuntu の locale を変更してみる。

```
% sudo apt-get install -y language-surrpot-ja
% update-locale LANG=ja_JP.UTF8
% sudo vim /etc/default/locale
# LANG=ja_JP.UTF-8
```

これでログインしなおすと

```
% echo $LANG
# => ja_JP.UTF-8
```

で、スクリーンショットを撮ってみるも相変わらず文字化け。そうか、フォントがないのか、と気付いてフォントをインストール。

```
% wget http://ipafont.ipa.go.jp/ipafont/IPAfont00303.php
% unzip IPAfont00303.php
% cd IPAfont00303/
% mkdir -p /usr/share/fonts/ipa
% cp *.ttf /usr/share/fonts/ipa
% fc-cache -fv
```

これでもダメ。が、調べてみると locale が `ja_JP.UTF-8` だと日本語フォントが出ないらしい。なんじゃそら。

```
% sudo vim /etc/default/locale
# LANG=en_US.UTF-8
```

できましたー。ちょっと phantomjs 殴りたい。
