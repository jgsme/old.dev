# [要素中の改行をそのまま出すCSS](/2015/04/06/white-space-pre-for-newline.html)

http://www.htmq.com/style/white-space.shtml

要素中のテキストの文字列中にある `\n` をそのまま改行として出すにはどうしたらええもんかなーという事案があって、泥臭く `<br>` に置換するみたいなことをしなくてはいけないのかな...と、調べてみると CSS でできるそうだ。

React だと

```livescript
DOM.div do
  style:
    whiteSpace: \pre
  'some\nnewline'
```

こういう感じで style を指定してやるだけでよい。
