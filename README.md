# f-array

  Some functional Array helpers for node.js

## Installation
    $ npm install f-array

## .zip(arrays...)
  Zip multiple arrays into an array of arrays

    [0, 1, 2, 3].zip([0, -1, -2, -3])
    // => [[0, 0], [1, -1], [2, -2], [3, -3]]

    Array.zip([1, 3, 5, 7], [2, 4, 6, 8])
    // => [[1, 2], [3, 4], [5, 6], [7, 8]]

    zip("and", "fish", "be")
    // => [['a', 'f', 'b'], ['n', 'i', 'e']]

## .unique()
  Return an array of unique/distinct elements of an array

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].unique()
    // => [1, 2, 4, 5, 6, 7]

    Array.unique(["and", "fish", "be", "fish"])
    // => ["and", "fish", "be"]

    unique("array")
    // => ['a', 'r', 'y']

## .dictionary(key)
  Create a dictionary Object from an Array of objects

    [
      { name: 'foo', value: 'bar' }
      { name: 'bar', value: 'baz' }
    ].dictionary('name')
    // =>
    // {
    //   'foo': { name: 'foo', value: 'bar' }
    //   'bar': { name: 'bar', value: 'baz' }
    // }

## .empty()
  Verify if an array is empty

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].empty()
    // => false

    Array.empty([])
    // => true

    empty("")
    // => true

## .remove(index/callback)
  Remove items from an array by index or function test
  _(affects original array)_

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].remove(2)
    // => [1, 1, 4, 5, 5, 5, 6, 7, 7]
    
    Array.remove([1, 1, 2, 4, 5, 5, 5, 6, 7, 7], function(e) { return e == 5; })
    // => [1, 1, 2, 4, 6, 7, 7]

    remove([1], 0)
    // => []

## License

The MIT License (MIT)

Copyright (c) 2013 Arthur Xavier &lt;arthur.xavierx@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
