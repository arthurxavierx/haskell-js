# src/haskell.array.coffee

# -begin
# Redefine Array methods to support Lambda
#
redefine = (method, aliases...) ->
  _method = Array.prototype[method]
  aliases.push method
  for alias in aliases
    Array.prototype[alias] = (fn, args...) ->
      _method.call @, fn.toFunction(), args...
    global[alias] = f[alias] = Array[alias] = (array, fn, args...) ->
      array[alias] fn.toFunction(), args...

# .forEach(fn)
redefine 'forEach', 'foreach'
# .map(fn)
redefine 'map'
# .reduce(fn, initial)
redefine 'reduce', 'fold', 'foldl'
# .reduceRight(fn, initial)
redefine 'reduceRight', 'foldr'
# .filter(fn)
redefine 'filter'
# .every(fn)
redefine 'every'
# .some(fn)
redefine 'some'

f.concat = Array.concat = (array, b) ->
  array.concat b

_push = Array.prototype.push
Array.prototype.push = (args...) ->
  _push.call @, args...
  @
global.push = f.push = Array.push = (array, args...) ->
  array.push args...

# -end
#

#
# Zip multiple arrays into an array of arrays
#
if !Array.prototype.zip
  global.zip = f.zip = Array.zip = ->
    lengthArray = (array.length for array in arguments)
    length = f.fold lengthArray, (a, b) -> Math.min a, b
    for i in [0...length]
      array[i] for array in arguments
  #
  Array.prototype.zip = ->
    Array.zip @, arguments...

#
# Return an array of unique elements in the array
#
if !Array.prototype.unique
  global.unique = f.unique = Array.unique = (array) ->
    unique = new Object
    unique[array[i]] = array[i] for i in [0...array.length]
    element for i, element of unique
  #
  Array.prototype.unique = ->
    Array.unique @

#
# Create a dictionary Object from an Array of objects
# @param key key to index the dictionary
#
if !Array.prototype.dictionary
  global.dictionary = f.dictionary = Array.dictionary = (array, key) ->
    array.reduce ((d, o) ->
      d[o[key]] = o if o[key]?
      d
    ), new Object
  #
  Array.prototype.dictionary = (key) ->
    Array.dictionary @, key

#
# Verify if an array is empty
#
if !Array.prototype.empty
  global.empty = f.empty = Array.empty = (array) ->
    array.length < 1
  #
  Array.prototype.empty = ->
    Array.empty @

#
# Verify if an array is a single tuple
#
if !Array.prototype.single
  Array.prototype.single = ->
    @length == 1
  #
  global.single = f.single = Array.single = (array) ->
    array.single()

#
# Return the top element of an array
#
if !Array.prototype.top
  global.top = f.top = Array.top = (array) ->
    array[array.length - 1]
  #
  Array.prototype.top = ->
    Array.top @

#
# Remove items from the array
# @param index/fn index of the element to remove or 
#function to test for elements to remove
#
if !Array.prototype.remove
  global.remove = f.remove = Array.remove = (array, index) ->
    if typeof index == "function"
      fn = index.toFunction()
      i = 0
      while i < array.length
        if fn(array[i], i, array)
          array.splice i, 1
          i--
        i++
    else
      array.splice index, 1
    return array;
  #
  Array.prototype.remove = (index) ->
    Array.remove @, index
