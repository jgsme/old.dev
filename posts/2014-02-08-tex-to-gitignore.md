# TeX 向けの .gitignore

アレがアレで現在進行形でめちゃくちゃTeXしている。転ばぬ先の杖の杖として、何重にもバックアップをしつつバージョン管理もしている。とはいえ、TeXはビルドするときにやたらファイルが生成されてgitで管理する邪魔になるので `.gitignore` に不要な拡張子を列挙して目に入らないようにするのがよいだろう。

完成版
```
*.aux
*.glo
*.idx
*.log
*.toc
*.ist
*.acn
*.acr
*.alg
*.bbl
*.blg
*.dvi
*.glg
*.gls
*.ilg
*.ind
*.lof
*.lot
*.maf
*.mtc
*.mtc1
*.out
*.synctex.gz
*.fdb_latexmk
*.fls
*.pdf
```

Happy TeX life!
