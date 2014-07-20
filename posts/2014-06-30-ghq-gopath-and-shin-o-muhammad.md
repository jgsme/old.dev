{
  title: "ghq と gopath の兼ね合い",
  date: "2014-06-30",
  description: "ghq と gopath の兼ね合い"
}

# TL;DR

* `$GOPATH` を `~/.ghq` にした
* `ghq.root` を `~/.ghq/src` にした

## 詳細

https://github.com/e-jigsaw/dotfiles/commit/23d70e1d30f9f23b20ee97cdb39cde1dbad1eec1

ghq マジ便利だな！ワッハッハ！と、何も考えずに `$GOPATH` を `~/.go` に、`ghq.root` を `~/.ghq` にしてたら、手元の go のリポジトリが重複することに気付いたので、ディレクトリ名を `.repos` とか `.projects` にしようとしたんだけど、どうにもしっくりこなかったのでそのまま `~/.ghq` にすることにした。

https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/ebook/01.3.md

Go でビルドしたバイナリを `$GOPATH/bin` に移すのは `go install` で出来るので、パッケージをアップデートしたりするときは適宜当該リポジトリへ行って `git pull` して `go install` すればいい。
