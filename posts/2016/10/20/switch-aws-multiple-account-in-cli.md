# [aws cli で複数アカウントを切り替える](/2016/10/20/switch-aws-multiple-account-in-cli.html)

また仕事が激忙で間が空いてしまった。

ちゃんと AWS と向き合うのも悪くないかな〜とおもって時間をみつけて整備してみている。

今日は cli で仕事の AWS アカウントと個人アカウントを切り替えるにはどうすれば...?となって調べてみたら `aws` コマンドにちゃんと備わっていた。

[AWS CLI のprofileを簡単に切り替える - tail my trail](http://uorat.hatenablog.com/entry/2015/10/16/023008)

```sh
✈ aws configure --profile jgs
AWS Access Key ID [None]: ...
AWS Secret Access Key [None]: ...
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

みたいな感じでプロンプトに入力したら `~/.aws` 以下のファイルが更新されていた。

実際に切り替えて使うには

```sh
✈ aws s3 ls --profile jgs
```

と `profile` オプションを付けてやればいいようだ。省略すると `default` が用いられるようだった。
