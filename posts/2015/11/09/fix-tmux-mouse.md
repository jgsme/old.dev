# [tmux v2 以降のマウスの設定](/2015/11/09/fix-tmux-mouse.html)

http://qiita.com/jyotti/items/70a3a8035d767f99f93d

tmux のバージョンが上がってマウスまわりの設定でエラーが出た。2系以降では↑のリンクにもある通り

```
set-option -g mouse on
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
```

と設定すればよいとのこと。ついでにだいぶ長らくほったらかしになっていた dotfiles まわりを整理した。`.atom` はわりと頻繁にメンテしているのだけれど。
