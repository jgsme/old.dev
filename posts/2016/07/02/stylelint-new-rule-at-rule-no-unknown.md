# [stylelint で CSS Modules の values がエラーになる件の対処](/2016/07/02/stylelint-new-rule-at-rule-no-unknown.html)

なんやかんや書かないとな〜とおもっているうちに数ヶ月が過ぎてしまった。忙しいと大変。

さて今日は stylelint をアップデートしたら(正確には `stylelint-config-standard` だけど) CSS Modules の `@value ...` 構文でエラーになるようになってしまったのでその対処をした。

`at-rule-no-unknown` という rule に引っかかってるので rule の [README](https://github.com/stylelint/stylelint/blob/6ae1e9bebb18a2193e4ebbdec6f950f89c4833b2/src/rules/at-rule-no-unknown/README.md) を参照すると `.stylelintrc` に

```json
  "rules": {
    "at-rule-no-unknown":[true, {
      "ignoreAtRules": ["value"]
    }]
  }
```

てな感じのオプションを渡してやればよいとのこと。

Happy linting!!
