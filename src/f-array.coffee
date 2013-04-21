# src/f-array.coffee

FArray = Array

#
# Zip multiple arrays into an array of arrays
#
if !FArray.zip
  global.zip = FArray.zip = ->
    lengthArray = (array.length for array in arguments)
    length = Math.min(lengthArray...)
    for i in [0...length]
      array[i] for array in arguments
#
if !FArray.prototype.zip
  FArray.prototype.zip = ->
    FArray.zip @, arguments...


#
# Returns an array of unique elements in the array
#
if !FArray.prototype.unique
  FArray.prototype.unique = ->
    unique = new Object
    unique[@[i]] = @[i] for i in [0...@length]
    element for i, element of unique

#
# Creates a dictionary Object from an Array of objects
# @param key key to index the dictionary
#
if !FArray.prototype.dictionary
  FArray.prototype.dictionary = (key) ->
    @reduce ((d, o) ->
      d[o[key]] = o if o[key]?
      d
    ), new Object

#
# Verifies if an array is empty
#
if !FArray.prototype.empty
  FArray.prototype.empty = ->
    @length < 1

#
# Remove items from the array
# @param index/callback index of the element to remove or 
#function to test for elements to remove
#
if !FArray.prototype.remove
  FArray.prototype.remove = (index) ->
    if typeof index == "function"
      callback = index
      i = 0
      while i < @length
        if callback(this[i], i, this)
          this.splice i, 1
          i--
        i++
    else
      this.splice index, 1

    return this;

#
module.exports = FArray
