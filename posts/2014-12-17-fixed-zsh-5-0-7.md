# [zsh まわりを直した](/2014/12/17/fixed-zsh-5-0-7.html)

https://github.com/e-jigsaw/dotfiles

zsh のバージョンが上がったせいなのかなんなのか分からないけど、だいぶストレス溜まる感じになってたので直した

# incr がなんかとぶつかって勝手に最初の候補が補完されて死ぬ

* incremental completion の `incr-0.2.zsh` が Tab 押しで勝手に最初の項目が挿入されて、しかも復旧がめっちちゃめんどくさくなる問題
* https://github.com/e-jigsaw/dotfiles/commit/82acd27b4d6b78d824983b921a66e79e6586a37a
* `menu_complete` が悪さをしていたので消した

# git の completion が前と違ってウザい

* `git push` するときに `git push origin/HEAD` とか補完してきてそうじゃねーよってなる問題
* https://github.com/e-jigsaw/dotfiles/commit/9301332cc9850353fa881aaedaa7dd69fdd5a4c1
* git のディレクトリの `zsh/site-functions` の下に補完ファイルがあるのでそれを読み込むようにしてやれば良い
* 今まで `compinit` の位置が上にいたので下ろしたりした
