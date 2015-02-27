# [atomのもろもろアップデート](/2015/02/27/update-atom.html)

https://github.com/e-jigsaw/.atom/compare/9e0d96...56aa019

Atom 本体のバージョンも上げてなくてもろもろパッケージも上げてなかったので勢いで上げた。ついでにタブを縦表示に変えた。

https://gist.github.com/jasesmith/114da4e5310eda6238f0 を参考に

```less
atom-pane.pane {
  -webkit-flex-direction: row;
  -webkit-flex-wrap: wrap;
}

.tab-bar {
  height: auto;
  overflow-x: hidden;
  overflow-y: auto;
  -webkit-flex-direction: column;
  padding: 0;
  background: #1B1C1D;
  &.list-inline > li:first-child {
    padding-left: 10px;
    padding-right: 30px;
  }
  .tab {
    max-width: none;
    -webkit-flex: 0 0 auto;
    margin: 0;
    top: 0;
    padding: 0 20px 0 10px;
    &.active {
      -webkit-flex: 0 0 auto;
      width: auto;
    }
  }
}
```

とこのあたりを書いておけば縦表示にできる。

![2015-02-27 12 05 16](https://cloud.githubusercontent.com/assets/557961/6406860/f13dc20a-be78-11e4-9bec-7e7052412b06.png)

タブを開きまくってるときに横表示だとファイル名が潰れちゃって見にくかったんだけど、縦にすればスッキリ見れて良い。デメリットは長いファイル名のやつがあると横幅が長くなってエディタの領域が狭くなることかな。コード書いてるときはサイドバーを表示しないようにするようにしようかなー。あと Markdown のプレビューでもタブが出ちゃうのでそれ直したりとかせねば...

あと、編集されたファイルをより分かりやすくするために `modified` が付いてるタブは赤くするようにした。

![2015-02-27 12 06 23](https://cloud.githubusercontent.com/assets/557961/6406867/1bda2af8-be79-11e4-8e60-b96675d83f1e.png)

そんな感じです。
