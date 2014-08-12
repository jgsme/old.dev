{
  title: "mac に imagemagick をいれる",
  date: "2014-08-12",
  description: "mac に imagemagick をいれる",
  url: "install-imagemagick-on-mac"
}

http://stackoverflow.com/questions/7412208/imagemagick-and-os-x-lion-trouble

imagemagick をいれたらコケたので調べてみると...的なやつ。

```
brew install imagemagick --build-from-source
```

でオッケーだった、先にオプションなしでいれちゃってた場合なんかはよしなに削除しておくとよいのかもしれない。
