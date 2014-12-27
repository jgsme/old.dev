# nginxでsocket.io
追い詰められて構築したさくらVPSにsocket.io on nginxを構築した。

http://d.hatena.ne.jp/yoshi-ken/20120205

を参考にnginxの最新版をさくらVPSのCentOSにいれる。

http://blog.geta6.net/post/45741693575/nginx-1-3-14-websocket-proxy

を参考にsocket.ioがうまいこと動くようにconfigを書く。

ちなみに、herokuでいいやとおもっていたところherokuだとsocket.ioが `xhr-polling` じゃないと動かなくてこれだとパフォーマンスがクソだったので脱herokuするために入さくらした。heroku用に `xhr-polling` でずっとデバッグしていたけれど、`non-xhr-polling` だと爆速で感動した。
