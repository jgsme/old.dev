# [SVG を PNG に変換する](/2015/02/07/svg-convert-to-png.html)

http://blog.youria.jp/kyo/mac/svg_to_png_on_macosx/

OSX だと

```
% qlmanage -t -s $SIZE -o $PNG_FILE $SVG_FILE
```

で変換できるようだ。`qlmanage` って何かとおもったら Quick Look を CLI から使うようなもののよう。なので

```
% qlmanage -p $FILE
```

とかやると CLI から Finder で Quick Look してるみたいなホバーが出てくる。なので `Open` で Preview.app で開くまででもないけど `cat` や `less` で見れない〜みたいなファイルはこれで見たりすると楽かもしれない。
