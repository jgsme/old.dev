# [function definition file not found](/2015/10/22/function-definition-file-not-found.html)

久々に `brew update` したらいろいろアップデートされて、恐らく `zsh` もアップデートされたようで Enter を押す度に

```
VCS_INFO_formats:32: VCS_INFO_reposub: function definition file not found
```

とエラーが出るようになった。

調べてみると http://stackoverflow.com/questions/10585002/zsh-complains-about-rvm-rvm-cleanse-variables-function-definition-file-not-fo に書いてあるように `.zcompdump` をクリアすればいいようだった。消したら出なくなった。

どうもこのファイルに zsh の補完のための変数やら関数が記録されていて、アップデートした際にそれらに不整合が起きたのだろう。
