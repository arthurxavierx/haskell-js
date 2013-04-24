# src/haskell.coffee

#
# Make functions out of lambda strings
#
f = module.exports = (lambda = "") ->
  # trim the string
  lambda = lambda.trim()

  # default arguments list
  args = ['x']

  # split the function body by '->'
  lambda = lambda.split(/\s*\-\>\s*/).filter((a) -> a != "")

  # if has argument list, set the arguments
  args = lambda[0].split(' ').filter((a) -> a != "") if !lambda.single() and !lambda.empty()
  
  # if it has no arguments list, extract
  # an argument for each variable found
  args = lambda[0].match(/([a-z\_\$][\w\_\$]*)/ig)?.unique() or args if lambda.single()

  # trim the function body
  lambda = lambda.pop()?.trim() or ""

  # if there is no explicit variable in the lambda string,
  # write it out in the function
  variable = if !lambda.match(/([a-z\_\$][\w\_\$]*)/i)? then args[0] else ""

  # evaluate the function
  eval "(function(#{args}) { return (#{variable}#{lambda}); })"


String.lambda = String.toFunction = f.lambda = f
Function.prototype.lambda = Function.prototype.toFunction = -> @
String.prototype.lambda = String.prototype.toFunction = ->
  f @

#
# Returns a function with arguments applied
Function.prototype.c = Function.prototype.curry = (args...) ->
  f.curry this.toFunction(), args...
f.curry = f.c = (fn, args...) ->
  (args2...) -> fn.toFunction()(args..., args2...)


#
# includes
#
# @include "array"
# @include "sequence"
#
