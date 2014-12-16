{
  title: "Yosemite マシンゲットしたので環境を整えた",
  date: "2014-12-15",
  description: "Yosemite マシンゲットしたので環境を整えた",
  url: "setup-yosemite-machines"
}

https://github.com/e-jigsaw/dotfiles

# まえがき

会社でマシンが買い替えられるチャンスみたいなのが舞い込んできたので Mac mini と Macbook Air に換えたいとダメもとで頼んでみたら本当にやってきた。mini を 10.9, Air を 10.10(人柱的な)で運用しようと企んでいたところ、mini のプリインが 10.10 だったので諦めて両方とも 10.10 で運用することにした。

そのため、2台を別々にセットアップするのが確実にだるそうだったのと、同期に「cask 使ってないとか情弱かよ(意訳)」と煽られたので Package manage as Code 的なことをやろうと思い立ってモリモリやったのでその辺が本旨。

ついでにイチからセットアップしたのでいろいろ備忘録っぽく残しておこうかと。

# homebrew のインストール

http://brew.sh/

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

# `brew file`

以前は `brew bundle` が使えたので `Brewfile` で管理していたところ、`brew bundle` が nerf されたので管理を断念していた。今回調べてみて知ったのが `brew file` である。

* https://github.com/rcmdnk/homebrew-file
  * 本家リポジトリ
* https://github.com/e-jigsaw/dotfiles/blob/0b0322c01b2b0ece3832c89fb626a90e1ac9961e/Brewfile
  * オレの最高の `Brewfile` (執筆時点)

(めっちゃ便利)

もろもろのインストラクションに従って

```
$ brew install rcmdnk/file/brew-file
```

する。スラッシュ区切りのやつでもろもろインストールできるっぽいのでもしかしたら `brew tap` のところは冗長かもしれない。とりあえずそのまま置いてある。

インストールしたら `Brewfile` のあるリポジトリを設定する。

```
$ brew file set_repo -R https://github.com/e-jigsaw/dotfiles.git
```

ここなんだけど、`README.md` には user/repo でいけるという記載があるのだけれど、その記法だと ssh で git clone がかかってまっさらなマシンだと ssh の設定まわりがアレでコケたので https のフルパス指定にしたらうまくいった。

ここにかつて `brew bundle` で運用していた頃の残骸が残っていたので

```
$ brew file edit
```

でエディタが立ち上がって編集できるのでよしなに書き換える。書き換えたら

```
$ brew file install
```

で書いたパッケージがずんずん入る。いちいち `brew file` って打つのがダルかったので適当なタイミングで `alias bf='brew file'` とか `alias bfi='brew file install'` とかして楽をした。

ひとしきりできたら

```
$ brew file push
```

で変更が github に push される。ちなみに、最初なにも考えずに `brew file edit` したらデフォルトさんでコミットされちゃう事件が発生したのでそこは気をつけないといけないとおもった。

`Brewfile` の更新を反映させるときは

```
$ brew file pull
```

でいける。コンフリクトとかしたら `/usr/local/Library/user_repo` みたいなディレクトリがそれなのでそこへ行って適当に解消してやればよい。

あとは http://caskroom.io/ でパッケージを探して、あったら `bfe` して `bfi` する、を繰り返すだけで Package manage as Code みたいなことが実現できる。

# dotfiles を蒔く

```
$ git clone https://github.com/e-jigsaw/dotfiles.git .ghq/src/github.com/e-jigsaw/dotfiles
$ cd .ghq/src/github.com/e-jigsaw/dotfiles
$ git submodule init
$ git submodule update
$ sh install.sh
```

順番としては、dotfiles を蒔いて gitconfig を設定して `brew file` をセットアップするという流れだったので、`ghq` のことを見越して `ghq` フレンドリーなところに dotfiles を置いてからインストール(シンボリックリンクをホームに張りまくる)スクリプトを叩くという感じ。

# Finder まわりの設定

![](https://cloud.githubusercontent.com/assets/557961/5437871/eb223848-84b6-11e4-9fa1-76f4560e208f.png)

最終形態はこんな感じ。Xtrafinder を cask でインストールして、黒背景にしたり上タブにしたりしている。地味に便利なのがフォルダをまとめて上に表示する機能。サイドバーに `$HOME/.ghq/src` をいれておくと Finder からも自由にリポジトリ群にアクセスできて便利だったりとか。

# iTerm2

![](https://cloud.githubusercontent.com/assets/557961/5437997/2191f98a-84b8-11e4-9971-e9c9a4fa4951.png)

オレの最高のカラースキームを github 上にあげているので使いたいひとがいればどうぞ -> https://github.com/e-jigsaw/iTerm-2-Color-Themes/blob/master/thayer.itermcolors

フォントは ASCII コードは Adobe の Sourcecode Pro を、日本語は Osaka。それぞれ 18pt。ログインシェルを brew 産 zsh に変えるのをちょっと躊躇ってしまうので iTerm2 のデフォルトシェルを `/usr/local/bin/zsh` にして糊口を凌いでいる。タブ開いたときは素の zsh が立ち上がるようになってて、がっつりシェル触るときに tmux を立ち上げるというような運用。なんかに困ったら Terminal.app で素の bash を立ち上げてなんとかする。

# Dock

手短に

* 下
* アイコンサイズ最大
* 自動的に隠す
* 元から入ってるアプリケーションは全部削除
* 起動インジケータをオフ

10.9 までは下左寄せで使っていたのだけれど、その機能がどうやら Yosemite で削除されてしまっているらしく、forum 見ても解決法がわからなかったので諦めて下中央でとりあえず運用している。

# Trackpad

* スクロール方向反転も気持ち悪いのでオフ
* Launchpad は使わないのでオフ
* 通知センターも使わないのでオフ

## BetterTouchTool

* 3本指上で `Home` が押される
* 3本指下で `End` が押される

確か SnowLeopard まではこれデフォルトでできたとおもうんだけどできなくなってかなしみ。。

# Alfred

* 起動は `Cmd+Space`
* cask でいれたアプリケーションを叩くために `/opt/homebrew-cask/Caskroom` を Scope に含める
* `o Dropbox` でフォルダを開く、`f hoge` でファイル開く、`d word` で辞書検索

以前は `g hoge` で Google を検索したりしていたんだけどそんなに使わないことに気付いたので今は使っていない。

# Karabiner

cask の Karabiner が古かったので PR 送ったらすげー早さで merge された。

https://github.com/caskroom/homebrew-cask/pull/8124

`private.xml`:

```
<?xml version="1.0"?>
<root>
  <item>
    <name>Shift IME on/off</name>
    <identifier>remap.jis_shift2eisuukana_prefer_command</identifier>
    <autogen>__KeyOverlaidModifier__ KeyCode::SHIFT_L, KeyCode::SHIFT_L, KeyCode::JIS_EISUU</autogen>
    <autogen>__KeyOverlaidModifier__ KeyCode::SHIFT_R, KeyCode::SHIFT_R, KeyCode::JIS_KANA</autogen>
  </item>
  <item>
    <name>fn+backslash to backslash</name>
    <identifier>remap.fn_backslash_to_backslash</identifier>
    <autogen>
      __KeyToKey__
      KeyCode::BACKSLASH, ModifierFlag::FN | ModifierFlag::SHIFT_L,
      KeyCode::BACKSLASH, ModifierFlag::SHIFT_L
    </autogen>
    <autogen>
      __KeyToKey__
      KeyCode::BACKSLASH, ModifierFlag::FN,
      KeyCode::BACKSLASH, ModifierFlag::OPTION_L
    </autogen>
  </item>
</root>
```

という設定を書いて、左右の Shift 空押しで切り替わるようにしている。cmd にしてるひとが多いとおもうけど、cmd だと後続のキーでコマンドが実行されてめんどくさい事態が起きやすかったので Shift にした。Shift だと後続のキーと合わせて認識されても大文字が入力されるだけなのでリカバーがききやすい。

それから、Macbook Air 用に HHK っぽい Remap を書いた。

* Backquote -> Esc
* delete -> Backquote
* Backslash -> delete
* fn+Backslash -> Backslash

普段 HHK に慣れすぎて無意識でバックスラッシュを連打してしまうのでまずはこれを変えたかった。そうすると元々の delete が空くので delete にはバッククオートを当てた。あと Esc のつもりでバッククオートも連打してしまうのでここを Esc にした。するとバックスラッシュの行き場がなくなるので、しぶしぶ fn+Backslash でもともとの Backslash が出るようにした。これを XML に書いたんだけど、Modflag に option を設定しないと円マークが出てきてウザかった。順番の方も先に shift との組み合わせを先に書かないと縦棒が出なかった。

あと key repeat を体感に合わせて調整して最高の key repeat を設定した。とても入力がはかどる。

# アクセシビリティ

Yosemite になってさらにアクセシビリティのアクセシビリティ感が強まったような気がするけど気のせいかなあ。

* 透明度を下げる
* カーソルのサイズを大きく
* 通知音が鳴るときに画面を点滅させる
* 慣性スクロールなし
* ドラッグロックあり

この辺設定しとくと結構アクセシビリティ高まる。

# メニューバーあたり

* Bartender で不要だけどちょっと要ぐらいのやつをまとめる
* Menumeter で CPU, メモリ, ネットワークのグラフとかを出す
* ファストユーザスイッチャーを消す

# まとめ

Yosemite なマシンが2台きたので Package manage as Code 的なことを試した。実際には Mac mini の方でもろもろ試行錯誤をして `Brewfile` を更新して Macbook Air の方にデプロイしてお手軽に環境を構築できることを確認した。
