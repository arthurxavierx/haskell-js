# src/f-array.coffee

#
# Zip multiple arrays into an array of arrays
#
if !Array.prototype.zip
  global.zip = Array.zip = ->
    lengthArray = (array.length for array in arguments)
    length = Math.min(lengthArray...)
    for i in [0...length]
      array[i] for array in arguments
  #
  Array.prototype.zip = ->
    Array.zip @, arguments...


#
# Return an array of unique elements in the array
#
if !Array.prototype.unique
  global.unique = Array.unique = (array) ->
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
  global.dictionary = Array.dictionary = (array, key) ->
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
  global.empty = Array.empty = (array) ->
    array.length < 1
  #
  Array.prototype.empty = ->
    Array.empty @

#
# Remove items from the array
# @param index/callback index of the element to remove or 
#function to test for elements to remove
#
if !Array.prototype.remove
  global.remove = Array.remove = (array, index) ->
    if typeof index == "function"
      callback = index
      i = 0
      while i < array.length
        if callback(array[i], i, array)
          array.splice i, 1
          i--
        i++
    else
      array.splice index, 1
    return array;
  #
  Array.prototype.remove = (index) ->
    Array.remove @, index

#
module.exports = Array
