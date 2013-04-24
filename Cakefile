fs = require 'fs'
coffee = require 'coffee-script'
uglify = require 'uglify-js'
{spawn, exec} = require 'child_process'

build = (options = {}) ->
  ###coffee = spawn './node_modules/coffee-script/bin/coffee', [
    '-c'
    '-b'
    '-o'
    './lib'
    './src'
  ]
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> 
    console.log "done."

  exec './node_modules/uglify-js/bin/uglifyjs ./lib/haskell.js -o ./lib/f-array.js' if options.minify
  ###
  fs.readFile './src/haskell.coffee', 'utf8', (err, data) ->
    throw err if err
    data = data.replace /(\#\s*\@include\s[\"\']([a-z\.]+)[\"\'])/ig, (_, line, name) ->
      fs.readFileSync "./src/haskell.#{name}.coffee", 'utf8'

    data = coffee.compile data

    fs.writeFile './lib/haskell.js', data, (err) ->
      throw err if err
      console.log 'done.'

    if options.minify
      data = uglify.minify(data, fromString: true).code
      fs.writeFile './lib/haskell.min.js', data, (err) ->
        throw err if err
        console.log 'minified.'


test = ->
  build()
  mocha = spawn './node_modules/mocha/bin/mocha', [
    '-R', 'spec'
    '--colors'
    '--require', 'coffee-script'
    './test/haskell.test.coffee'
  ]
  mocha.stdout.pipe process.stdout
  mocha.stderr.pipe process.stderr

task 'minify', -> build(minify: true)
task 'build', -> build()
task 'test', -> test()
