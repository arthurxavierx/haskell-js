# haskell

> Lambda functions and functional programming for javascript

## Installation
    $ npm install haskell

## Lambda λ
  Make functions out of lambda strings

    f = require('haskell');

    add1 = f('+1');
    add1(1); // => 2

    f('x*x')(5); // => 25

    f('a b -> a+b')(1, 2); // => 3

    f('+2')(f('+1')(1)); // => 4

    greater_than_0 = f('>0');
    greater_than_0(1); // => true
    greater_than_0(-1); // => false

    array = [-1, 0, 1, 2];
    array.map('+1'); // => [0, 1, 2, 3]
    array.filter('>0'); // => [1, 2]
    array.map('+1').filter('>0'); => [1, 2, 3]
    array.every('>0'); // => false
    array.some('>0'); // => true

    f.fold([1, 2, 3, 4], 'a+b'); // => 10

    // reverse array
    [1, 2, 3, 4].foldr('a b -> a.push(b)', []); // => [4, 3, 2, 1]

    [1, 2, 3].map('+1').fold('a+b'); // => 9

### .curry(fn, args...)
  Curry a function with arguments. Returns a function with the arguments applied.

    add3 = f('a + b + c')
    add3(1, 2, 3);
    // => 6
    
    add3.curry(1); // f.curry(add3, 1);
    add3(1, 2);
    // => 4

    f.curry(add3, 2);
    add3(3);
    // => 6

    a = [-1, 0, 1, 2];
    a.map(f('a+b').curry(2)); // f.map(a, f.curry('a+b', 2))
    // => [1, 2, 3, 4]

## Array functions

### .zip([array,] arrays...)
  Zip multiple arrays into an array of arrays

    [0, 1, 2, 3].zip([0, -1, -2, -3])
    // => [[0, 0], [1, -1], [2, -2], [3, -3]]

    Array.zip([1, 3, 5, 7], [2, 4, 6, 8])
    // => [[1, 2], [3, 4], [5, 6], [7, 8]]

    zip("and", "fish", "be")
    // => [['a', 'f', 'b'], ['n', 'i', 'e']]

### .unique([array])
  Return an array of unique/distinct elements of an array

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].unique()
    // => [1, 2, 4, 5, 6, 7]

    Array.unique(["and", "fish", "be", "fish"])
    // => ["and", "fish", "be"]

    unique("array")
    // => ['a', 'r', 'y']

### .dictionary([array,] key)
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

### .empty([array])
  Verify if an array is empty

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].empty(); // => false

    Array.empty([]); // => true

    empty(""); // => true

### .single([array])
  Verify if an array is a single tuple

    [1, 1, 2, 4, 5, 5, 5, 6, 7, 7].single(); // => false

    Array.single([]); // => false

    f.single([1]); // => true

### .top([array])
  Return the top element of an array

    [1, 1, 2, 4, 5, 5, 5, 6, 6, 7].top(); // => 6

    Array.top([]); // => undefined

    top("Haskell"); // => "l"

### .remove([array,] index/callback)
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
