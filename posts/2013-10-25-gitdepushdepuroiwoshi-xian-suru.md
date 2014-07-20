{
  title: "gitでpushデプロイを実現する",
  date: "2013-10-25",
  description: "gitでpushデプロイを実現する"
}

参考: http://qiita.com/fnobi/items/98bd5d1c83c010842733

`nodectl` がとても便利なのでドンドン使っている(http://tech.jgs.me/2013/10/16/nodectl-metutiyabian-li/)。この `nodectl` 、ディレクトリを監視して自動でリロードする機能も備わっているので、`push` をフックに `pull` してやれば自動的にデプロイされることに気付いた。`forever` にもそんな機能があったはずなので、`forever` でもできるとおもう。

やることは、`.git` の中の `hooks/post-receive` に実行権限を付与して、シェルスクリプトを書いてやるだけだ。
