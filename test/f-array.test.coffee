# test/f-array.test.coffee
should = require 'should'
Array = require '../lib/f-array'

describe 'FArray', ->

  #
  it 'should zip multiple arrays', ->
    [0, 1, 2, 3].zip([0, -1, -2, -3]).should.eql [[0, 0], [1, -1], [2, -2], [3, -3]]
    Array.zip([0, 1, 2, 3], [0, -1, -2, -3]).should.eql [[0, 0], [1, -1], [2, -2], [3, -3]]
    zip("and", "fish", "be").should.eql [['a', 'f', 'b'], ['n', 'i', 'e']]

  #
  it 'should return an array of unique elements', ->
    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].unique().should.eql [1, 2, 4, 5, 6, 7]
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
    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].empty().should.equal false
    [].empty().should.equal true

  #
  it 'should remove elements from the array by index or function test', ->
    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].remove(2).should.eql [1, 1, 4, 5, 5, 5, 6, 7, 7]
    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].remove((e) -> e == 5).should.eql [1, 1, 2, 4, 6, 7, 7]
    [1].remove(0).should.eql []
