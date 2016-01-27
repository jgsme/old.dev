# [Karabinar の設定を外付けキーボードと元々のキーボードで使い分ける](/2016/01/27/switch-karabinar-config.html)

以前 Macbook Air を使っていた頃に、バックスラッシュをデリートにしたりして利便性を高めていたのだが、HHK をつなげると設定が共有されてしまって HHK のデリートが効かなくなったりした。そこで、調べてみると `private.xml` はデバイスを指定するディレクティブがあるようだ。

```xml
<?xml version="1.0"?>
<root>
  <devicevendordef>
    <vendorname>APPLE</vendorname>
    <vendorid>0x05ac</vendorid>
  </devicevendordef>
  <deviceproductdef>
    <productname>INTERNAL</productname>
    <productid>0x0273</productid>
  </deviceproductdef>
  <item>
    <name>Backquote to Escape in Apple Keyboard only</name>
    <identifier>remap.backquote_to_esc_apple</identifier>
    <device_only>DeviceVendor::APPLE, DeviceProduct::INTERNAL</device_only>
    <autogen>
      __KeyToKey__
      KeyCode::BACKQUOTE,
      KeyCode::ESCAPE
    </autogen>
  </item>
</root>
```

こんな感じで `devicevendordef` と `deviceproductdef` にそれぞれ Karabinar の Event Viewer で確認した値を設定してやると `item` の `device_only` ディレクティブで参照できるようになる。あとはこの調子で元々オリジナルで使っていたものを `device_only` 付きの `item` として移植してやればオッケーだった。

逆に外付けのキーボードだけで使いたい設定でも使えるとおもう。
