require! {
  fs
  inquirer
  mkdirp
}

inquirer.prompt [
  * type: 'input'
    name: 'title'
    message: 'title'
  * type: 'input'
    name: 'url'
    message: 'url'
], (answers)->
  {title, url} = answers

  today = new Date!
  year = today.getFullYear!
  month = today.getMonth! + 1
  day = today.getDate!
  if month.toString!.length is 1 then month = "0#{month}"
  if day.toString!.length is 1 then day = "0#{day}"

  mkdirp.sync "./posts/#{year}/#{month}/#{day}"
  fs.writeFileSync "./posts/#{year}/#{month}/#{day}/#{url}.md", "# [#{title}](/#{year}/#{month}/#{day}/#{url}.html)\n\n"
