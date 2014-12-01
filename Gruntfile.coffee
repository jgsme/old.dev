module.exports = (grunt) ->
  grunt.initConfig
    pages:
      posts:
        src: 'posts'
        dest: 'dist'
        layout: 'src/layouts/post.jade'
        url: 'posts/:url/'
        options:
          pageSrc: 'src/pages'
          data:
            baseUrl: '/'
          pagination:
            postsPerPage: 1
            listPage: 'src/pages/index.jade'
          rss:
            title: 'Kaihatsu'
            description: 'Development log'
            author: 'jigsaw (http://jgs.me)'
            url: 'http://dev.jgs.me'
            numPosts: 5

    copy:
      dist:
        files: [
          expand: true
          cwd: 'src'
          dest: 'dist'
          src: [
            'images/**'
            'scripts/**'
            'CNAME'
          ]
        ]
      style:
        files:
          'dist/styles/github-markdown.css': 'github-markdown-css/github-markdown.css'

    stylus:
      compile:
        files:
          'dist/styles/main.css': 'src/styles/main.styl'

    watch:
      pages:
        files: [
          'posts/**'
          'src/layouts/**'
          'src/pages/**'
        ]
        tasks: ['pages']
      stylus:
        files: ['src/styles/**']
        tasks: ['stylus']
      copy:
        files: [
          'src/images/**'
        ]
        tasks: ['copy']
      dist:
        files: ['dist/**']
        options:
          livereload: true

    connect:
      dist:
        options:
          port: 5455
          hostname: '0.0.0.0'
          base: 'dist'
          livereload: true

    open:
      dist:
        path: 'http://localhost:5455'

    clean:
      dist: [
        'dist'
        '.grunt'
        '.sass-cache'
      ]

    'gh-pages':
      options:
        base: 'dist'
      src: ['**']

  grunt.registerTask 'build', [
    'clean'
    'pages'
    'stylus'
    'copy'
  ]

  grunt.registerTask 'deploy', [
    'clean'
    'build'
    'gh-pages'
  ]

  grunt.registerTask 'server', [
    'build'
    'connect'
    'open'
    'watch'
  ]

  grunt.registerTask 'write', ->
    fs = require 'fs'
    inquirer = require 'inquirer'
    done = @async()
    inquirer.prompt
      type: 'input'
      name: 'title'
      message: 'title'
    , (titleAnswer)->
      inquirer.prompt
        type: 'input'
        name: 'url'
        message: 'url'
      , (urlAnswer)->
        now = new Date()
        zerocomp = (num)-> if num.toString().length is 1 then "0#{num}" else num.toString()
        strNow = "#{now.getFullYear()}-#{zerocomp(now.getMonth()+1)}-#{zerocomp(now.getDate())}"
        fs.writeFile "posts/#{strNow}-#{urlAnswer.url}.md", "{\n  title: \"#{titleAnswer.title}\",\n  date: \"#{strNow}\",\n  description: \"#{titleAnswer.title}\",\n  url: \"#{urlAnswer.url}\"\n}\n\n", (err)->
          console.log err if err?
          done()

  grunt.registerTask 'default', 'server'

  require('load-grunt-tasks')(grunt)
