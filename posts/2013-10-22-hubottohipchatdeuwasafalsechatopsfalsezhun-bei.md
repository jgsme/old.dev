# hubotとhipchatでウワサのChatOpsの準備
むかし見かけたけど、あまり便利さがわからなかったのでスルーしていた `hubot` が面白そうだったので、ちょっと触ってみることにした。

目標は、サービスのデプロイや、通知なんかを一手に管理できる状態。

`hubot` のインストールは簡単で `npm` からインストールするだけ。

`
% npm install -g hubot
`

インストールしたら

`
% mkdir YOUR_BOT_NAME
% hubot --create YOUR_BOT_NAME
`

でテンプレートを展開してくれる。`coffee` がないよ！って言われるときは `% npm install -g coffee-script` してやればOK。

初期状態だと `redis-brain` という保存用の `redis` が走るようになっているので `hubot-scripts.json` から `redis-brain.coffee` を削除してから起動してみる。

```
% hubot -n Alfred
```

 `-n` で名前を指定できるので適当に指定してやる。シェルで起動したら

```
Alfred> @Alfred ping
Alfred> PONG
```

みたいな感じで確認できる。

うまいことウェブから操作できないかなあ、といろいろ探してみたところ `hiptchat` をインターフェイスにするのがよさげだったので http://www.hipchat.com から適当に登録。チャットルームにBOTを追加するのが意外と面倒で、`hipchat` の `Room` の設定ページから `invite url` を取得してきて、`Sign out` してから `invite url` を踏んでBOT用のアカウントを登録する。メアドめんどくさいときには `your_name+botname@gmail.com` みたいな感じで `Gmail` の便利機能を使えばよい。

あとは、`hubot` のディレクトリで

```
% npm install hubot-hipchat --save
```

としてやって `adapter` をインストールして環境変数を設定する。面倒なのでシェルスクリプトを作っておくとよい。

```
export HUBOT_HIPCHAT_TOKEN="RoomのAdminのToken"
export HUBOT_HIPCHAT_JID="BotのアカウントのJabbr ID"
export HUBOT_HIPCHAT_PASSWORD="BotアカウントのPassword"
export HUBOT_HIPCHAT_ROOMS="Roomの名前"

exec bin/hubot "$@" -n BOT_NAME -a hipchat
```

みたいな `start.sh` を準備して

```
% sh start.sh
```

としてやれば起動する。あとは `hipchat` 側で `@alfred ping` してやれば `PONG` が返ってくる。

ひとまずこれで準備は完了。意外と `hipchat` の設定がダルくて、事前にボット用のアカウントを作成しておくと、それを `Room` に追加する手段がなくて消して `invite url` から作りなおしたらいけた。
