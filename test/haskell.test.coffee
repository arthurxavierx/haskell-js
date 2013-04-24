
# test/haskell.test.coffee
should = require 'should'
f = require '../lib/haskell'

describe 'haskell', ->
  
  #
  it 'should make lambda functions from strings', ->
    # empty lambda
    f()(1).should.equal 1

    # single-argument lambda
    f('+1')(1).should.equal 2

    # square
    f('x*x')(5).should.equal 25

    # multiple argument lambda
    f('a b -> a+b')(1, 2).should.equal 3

    # function nesting
    f('+2')(f('+1')(1)).should.equal 4

    # comparation lambda
    greater_than_0 = f '>0'
    greater_than_0(1).should.equal true
    greater_than_0(-1).should.equal false

    # applying lambda as functions for array operations
    a = [-1..2]
    # add 1 to each element
    a.map('+1').should.eql [0, 1, 2, 3]
    # only elements greater than 0
    a.filter('>0').should.eql [1, 2]
    #
    a.map('+1').filter('>0').should.eql [1, 2, 3]
    #
    a.every('>0').should.equal false
    a.some('>0').should.equal true
    #
    f.fold([1, 2, 3, 4], 'a+b').should.equal 10
    # reverse array
    [1, 2, 3, 4].foldr('a b -> f.push(a, b)', []).should.eql [1, 2, 3, 4].reverse()
    #
    [1, 2, 3].map('+1').fold('a+b').should.eql [2, 3, 4].reduce(f 'a+b')
    

  it 'should make currying', ->
    add_1 = f '+1'
    add_1_2 = add_1.curry 2
    add_1_2().should.equal 3
    #
    a = [-1..2]
    a.map(f.curry('a+b', 2)).should.eql [1, 2, 3, 4]
    a.map('+1').should.eql [0, 1, 2, 3]
    #
    add3 = f 'a + b + c'
    add3(1, 2, 3).should.equal 6
    add3 = f.curry add3, 1, 2
    add3(3).should.equal 6

  #
  describe 'haskell.Array', ->

    #
    it 'should zip multiple arrays', ->
      [0, 1, 2, 3].zip([0, -1, -2, -3]).should.eql [[0, 0], [1, -1], [2, -2], [3, -3]]
      Array.zip([0, 1, 2, 3], [0, -1, -2, -3]).should.eql [[0, 0], [1, -1], [2, -2], [3, -3]]
      f.zip("and", "fish", "be").should.eql [['a', 'f', 'b'], ['n', 'i', 'e']]

    #
    it 'should return an array of unique elements', ->
      [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].unique().should.eql [1, 2, 4, 5, 6, 7]
      Array.unique(["and", "fish", "be", "fish"]).should.eql ["and", "fish", "be"]
      f.unique("array").should.eql ['a', 'r', 'y']
      [].unique().should.eql []

    #
    it 'should create a dictionary from an array', ->
      [
        { name: 'foo', value: 'bar' }
        { name: 'bar', value: 'baz' }
      ].dictionary('name').should.eql {
        'foo': { name: 'foo', value: 'bar' }
        'bar': { name: 'bar', value: 'baz' }
      }

    #
    it 'should verify if an array is empty', ->
      [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].single().should.equal false
      Array.single([]).should.equal false
      f.single([1]).should.equal true

    #
    it 'should verify if an array is a single tuple', ->
      [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].empty().should.equal false
      Array.empty([]).should.equal true
      f.empty("").should.equal true

    #
    it 'should return the top element of an array', ->
      [1, 1, 2, 4, 5, 5, 5, 6, 6, 7].top().should.equal 7
      should.not.exist Array.top([])
      top("Haskell").should.equal "l"

    #
    it 'should remove elements from the array by index or function test', ->
      [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].remove(2).should.eql [1, 1, 4, 5, 5, 5, 6, 7, 7]
      [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].remove((e) -> e == 5).should.eql [1, 1, 2, 4, 6, 7, 7]
      f.remove([1], 0).should.eql []

  #
  describe 'haskell.Sequence', ->

    #
    it 'should make sequences from arrays', ->
      s = new Sequence [-1, 1]
      s.sequence.should.eql [-1, 1]
      s.get(0).should.eql -1
      s.get(0, 1).should.eql [-1, 1]

      [1, 2, 3, 4].sequence().get(0, 2).should.eql [1, 2, 3]

    #
    it 'should concatenate sequences', ->
      s = new Sequence [1, 2, 3, 4]
      s.set [-1, -2], 2
      s.sequence.should.eql [1, 2, -1, -2]

    #
    it 'should make sequences out of lambdas and functions', ->
      s = new Sequence 'x'
      s.get(100000).should.eql 100000
      s.get(0, 4).should.eql [0, 1, 2, 3, 4]

    #
    it 'should make inverse sequences', ->
      new Sequence([1, 2, 3, 4]).inverse().get(0, 3).should.eql [1, 1/2, 1/3, 1/4]
      new Sequence([1, 2, 3, 4]).inverse().get(0, 3).should.eql [1, 1/2, 1/3, 1/4]

    #
    it 'should make negative sequences', ->
      new Sequence([1, 2, 3, 4]).negative().get(0, 3).should.eql [-1, -2, -3, -4]
      new Sequence([1, 2, 3, 4]).negative().get(0, 3).should.eql [-1, -2, -3, -4]

