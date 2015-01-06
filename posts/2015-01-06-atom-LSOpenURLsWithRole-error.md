# [tmux から atom コマンドでファイルを開こうとするとエラーが出る問題](/2015/01/06/atom-LSOpenURLsWithRole-error.html)

https://github.com/atom/atom/issues/3093

`atom-script` というパッケージがアップデートでシェルから `atom` コマンドで起動しないとスクリプトが実行できなくなっていたので、`open -a Atom` のエイリアス類を全部 `atom` に変更したところ、素 zsh 環境では起動するものの tmux からだと

```
LSOpenURLsWithRole() failed for the application /Applications/Atom.app with error -10810.
```

とエラーが出て起動しなかった。調べてみると細かいエラーの原因の特定にまでは至らなかったが、対処方法は分かったのでメモ。

`.tmux.conf` に

```
set-option -g default-command "which reattach-to-user-namespace > /dev/null && reattach-to-user-namespace -l $SHELL || $SHELL"
```

を追加すると起動するようになる。ちなみに、`reattach-to-user-namespace` というパッケージが入ってないと動かないので

```
% brew install reattach-to-user-namespace
```

でパッケージをインストールする。
