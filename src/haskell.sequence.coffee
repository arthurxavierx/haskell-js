# src/haskell.sequence.coffee

#
# 
#
class f.Sequence
  formula: null
  sequence: []

  set: (sequence, index = 0) ->
    if typeof sequence == "function" or typeof sequence == "string"
      @formula = sequence.toFunction()
    else
      @sequence = (if index == 0 then sequence else @sequence.map (a, i) -> if i >= index and i < index+sequence.length then sequence[i-sequence.length] else a)

  #
  #
  get: (index, size = 0)->
    if @formula
      return @formula.call @sequence or @, index if size == 0
      return (@formula.call @sequence or @, index+i for i in [0..size])
    return @sequence[index] if size == 0
    @sequence.slice index, size+1

  #
  #
  inverse: ->
    _f = @formula
    new Sequence(if _f then (x) -> 1/_f(x) else @sequence.map '1/x')

  #
  #
  negative: ->
    _f = @formula
    new Sequence(if _f then (x) -> -_f(x) else @sequence.map '-x')
  
  #
  #
  constructor: (sequence) ->
    @set sequence

global.Sequence = f.Sequence

#
#
#
f.seq = f.sequence = (sequence) ->
  new Sequence(sequence)
Array.prototype.sequence = ->
  new Sequence @
