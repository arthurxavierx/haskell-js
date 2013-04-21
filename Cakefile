fs = require 'fs'
coffee = require 'coffee-script'
uglify = require 'uglify-js'
{spawn, exec} = require 'child_process'

build = (options = {}) ->
  coffee = spawn './node_modules/coffee-script/bin/coffee', [
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

  exec './node_modules/uglify-js/bin/uglifyjs ./lib/f-array.js -o ./lib/f-array.js' if options.minify

test = ->
  build()
  mocha = spawn './node_modules/mocha/bin/mocha', [
    '-R', 'spec'
    '--colors'
    '--require', 'coffee-script'
    './test/f-array.test.coffee'
  ]
  mocha.stdout.pipe process.stdout
  mocha.stderr.pipe process.stderr

task 'minify', -> build(minify: true)
task 'build', -> build()
task 'test', -> test()
