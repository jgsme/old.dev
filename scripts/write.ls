require! {
  fs
  inquirer
  mkdirp
}

zerocomp = (num)-> if num.toString!.length is 1 then "0#{num}" else num.toString!

answers <- inquirer.prompt [
  * type: 'input'
    name: 'title'
    message: 'title'
  * type: 'input'
    name: 'url'
    message: 'url'
]

{title, url} = answers
today = new Date!
year = today.getFullYear!
month = today.getMonth! + 1 |> zerocomp
day = today.getDate! |> zerocomp

mkdirp.sync "./posts/#{year}/#{month}/#{day}"
fs.writeFileSync "./posts/#{year}/#{month}/#{day}/#{url}.md", "# [#{title}](/#{year}/#{month}/#{day}/#{url}.html)\n\n"
