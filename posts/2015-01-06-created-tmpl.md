# [tmpl という scaffold generator をつくった](/2015/01/06/created-tmpl.html)

https://github.com/e-jigsaw/tmpl

今までに何度か Scaffold generator みたいなやつを作ろうと試みるも、使うモジュールのアップデートとかもまあまああるし、Scaffold generator を作るコストの方が使って楽できるメリットを上回る気がしなくて作ってこなかった。けれど、最近ぱぱっと作ることが多くなってきて、いよいよ最初に `gulpfile` 書いたりとか、`README` 書いたりするのがめんどくさくなってきたので勢いでつくった。

1. どのテンプレートから生成するかのプロンプト(`Tmpls` のディレクトリ名を出してるだけ)
2. 選択されたテンプレートの `question` を元にプロンプトを出す
3. 必要事項が入力されたらテンプレートの `actions` がキックされる

という単純な仕組みである。`README` にも書いた通り、`question` は `inquirer` というプロンプトライブラリのオプションオブジェクトでしかないし、`actions` はいくつかのメソッドが呼び出せるだけの単純な関数だ。

Github pages の Scaffold であればこれだけで良い

```coffee
exports.questions = [
  {
    type: 'input'
    name: 'name'
    message: 'name'
    default: process.cwd().split('/')[process.cwd().split('/').length-1]
  }
  {
    type: 'input'
    name: 'description'
    message: 'description'
  }
]

exports.actions = (answers)->
  @mkdir 'src'
  @template 'README.md',
    name: answers.name
    description: answers.description
    partition: answers.name.replace /./g, '='
  @template 'package.json',
    name: answers.name
    description: answers.description
  @template 'src/index.jade',
    name: answers.name
  @copy '_gitignore', '.gitignore'
  @copy 'gulpfile.coffee'
  @copy 'src/index.coffee'
  @copy 'src/index.styl'
```

読んでそのままという感じだが、`@mkdir` はディレクトリを作る(`@copy` と `@template` だけにしようかなとおもってる, 出力先のパス見て勝手に `mkdir` してくれればいいだけだし)関数で、`@template` は handlebars のテンプレートをローカル変数を元に生成する関数、`@copy` は単純なコピーをする関数である。

これらを用意しておくだけでなにかを作るときの初期コストがぐっと下がって、目的にものをすぐ作れるようになるのでとても良い。
