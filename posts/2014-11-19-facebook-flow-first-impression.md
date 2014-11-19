{
  title: "facebook-flow first impression",
  date: "2014-11-19",
  description: "facebook-flow first impression",
  url: "facebook-flow-first-impression"
}

http://flowtype.org/

既に数人 Facebook Flow の感想を上げていたのでリンクを貼っておく

* [facebook/flowファーストインプレッション - Qiita](http://qiita.com/mizchi/items/d50fbdd8c2dcd01c38f9)
* [facebook/flow 実践編 - Qiita](http://qiita.com/mizchi/items/fe1e7bc0acecb043cc56)
* [はじめてのfacebook/flow - Qiita](http://qiita.com/varmil/items/66f220abd59e04bb431c)
* [Facebook Flowの初見の感想 - Qiita](http://qiita.com/vvakame/items/53a464681920e6c55b31)

vvakame さんの記事中の [生JSに型注釈版のサジェストをくれる](http://qiita.com/vvakame/items/53a464681920e6c55b31#%E7%94%9Fjs%E3%81%AB%E5%9E%8B%E6%B3%A8%E9%87%88%E7%89%88%E3%81%AE%E3%82%B5%E3%82%B8%E3%82%A7%E3%82%B9%E3%83%88%E3%82%92%E3%81%8F%E3%82%8C%E3%82%8B) がすげーとおもった。

とりあえずやったこと

# インストール

ビルドしようとおもって `clone` して `make` したら

```
✈ make
mkdir -p bin
tar czf bin/flowlib.tar.gz lib
echo 'const char* const BuildInfo_kRevision = "";' > hack/utils/get_build_id.gen.c
ocamlbuild  -cflags "" src/embedded/flowlib_elf.o hack/heap/hh_shared.o hack/utils/realpath.o hack/fsevents/fsevents_stubs.o hack/utils/nproc.o hack/hhi/hhi_elf.o hack/utils/get_build_id.gen.o hack/utils/get_build_id.o
/bin/sh: ocamlbuild: command not found
make: *** [build-flow-native-deps] Error 127
```

ってんで homebrew から OCamlいれようとおもったけどめんどくさくなったんでやめた。

```
✈ unzip flow-osx-latest.zip
Archive:  flow-osx-latest.zip
   creating: flow/
   creating: flow/examples/
   creating: flow/examples/01_HelloWorld/
 extracting: flow/examples/01_HelloWorld/.flowconfig
   creating: flow/examples/01_HelloWorld/answer/
  inflating: flow/examples/01_HelloWorld/answer/hello.js
 extracting: flow/examples/01_HelloWorld/hello.js
   creating: flow/examples/02_TypeAnnotations/
 extracting: flow/examples/02_TypeAnnotations/.flowconfig
   creating: flow/examples/02_TypeAnnotations/answer/
...
```

# とりあえず試す

```
✈ ../flow/flow suggest index.flow.js
Could not find a .flowconfig in . or any of its parent directories
```

`.flowconfig` がいるらしい

```
✈ ../flow/flow init
```

```
✈ cat .flowconfig
[ignore]

[include]
```

```
✈ ../flow/flow suggest index.flow.js
Flow server launched for /Users/jigsaw/tmp/sandbox
Spawned flow server (child pid=1825)
Logs will go to /var/folders/66/dzc50yws081g_s252qx9_lvm0000gn/T/flow_jigsaw/jigsaw-zSUserszSjigsawzStmpzSsandbox.log
The flow server will be ready in a moment.
/Users/jigsaw/tmp/sandbox/index.flow.js
--- old
+++ new
@@ -1,5 +1,5 @@
 /* @flow */
-function add(x, y) {
+function add(x: number, y: number) : number{
   return x + y;
 }
```

できとる〜〜〜

ところで、`Spawned flow server` とか言ってるので確認してみると

```
✈ ps aux | grep flow
jigsaw           1825   0.0  1.0 21269916 168164   ??  SNs   9:17PM   0:00.11 ../flow/flow start /Users/jigsaw/tmp/sandbox
jigsaw           2027   0.0  0.0  2432784    600 s000  S+    9:19PM   0:00.00 grep flow
jigsaw           1830   0.0  0.0 20704672   4832   ??  SN    9:17PM   0:00.01 ../flow/flow start /Users/jigsaw/tmp/sandbox
jigsaw           1829   0.0  0.0 20729568   4104   ??  SN    9:17PM   0:00.00 ../flow/flow start /Users/jigsaw/tmp/sandbox
jigsaw           1828   0.0  0.0 20729568   4096   ??  SN    9:17PM   0:00.00 ../flow/flow start /Users/jigsaw/tmp/sandbox
jigsaw           1827   0.0  0.0 20729568   4096   ??  SN    9:17PM   0:00.00 ../flow/flow start /Users/jigsaw/tmp/sandbox
jigsaw           1826   0.0  0.0 20729568   4096   ??  SN    9:17PM   0:00.00 ../flow/flow start /Users/jigsaw/tmp/sandbox
```

めっちゃいる。殺し方は `flow stop` とのこと。ドキュメントを読むに、`flow start` してから始める方が王道っぽい。

```
✈ ../flow/flow stop
Killing server for /Users/jigsaw/tmp/sandbox
Attempting to nicely kill server for /Users/jigsaw/tmp/sandbox
Successfully killed server for /Users/jigsaw/tmp/sandbox
```

ログを見てみると

```
✈ cat /var/folders/66/dzc50yws081g_s252qx9_lvm0000gn/T/flow_jigsaw/jigsaw-zSUserszSjigsawzStmpzSsandbox.log
Initializing Server (This might take some time)
Server is READY
recheck 1 files:
1/1: /Users/jigsaw/tmp/sandbox/index.flow.js
recheck 1 files:
1/1: /Users/jigsaw/tmp/sandbox/mod.flow.js
recheck 1 files:
1/1: /Users/jigsaw/tmp/sandbox/mod.flow.js
recheck 1 files:
1/1: /Users/jigsaw/tmp/sandbox/index.flow.js
```

というような感じで変更のあったファイルだけを recheck しているような挙動をしているっぽい

型のことは詳しくないので先に挙げた記事をお読みくださいという感じで、実運用というか、コード書いていくときにどれぐらい役に立つんだろうなーというあたりが気になる。オフィシャルにも書いてある通り、

> Flow is a static type checker for JavaScript.

らしいので実際動くコードにコンパイルするためには `react-tools` がいるような現況なのではたしてどうなるやらという感じなのかなー。
