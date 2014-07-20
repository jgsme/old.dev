{
  title: "vimで補完",
  date: "2013-10-06",
  description: "vimで補完",
  url: "vim-comp"
}

vim で補完をしたい。

完成形:

https://github.com/e-jigsaw/dotfiles/commit/1c7f0271cdc283786d446bb5c69d511830716f33

ほんとは `neocomplete.vim` を使いたかったんだけど、環境の制約が結構激しくて断念して `neocomplcache` にした。

ところで、`dotfiles` を `git` で管理してるので `vim` の `module` も全て `submodule` で管理しているのだけれど、これでいいのかはわからない。
