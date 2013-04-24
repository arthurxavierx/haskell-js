(function() {
  var f, redefine, _push,
    __slice = [].slice;

  f = module.exports = function(lambda) {
    var args, variable, _ref, _ref1;

    if (lambda == null) {
      lambda = "";
    }
    lambda = lambda.trim();
    args = ['x'];
    lambda = lambda.split(/\s*\-\>\s*/).filter(function(a) {
      return a !== "";
    });
    if (!lambda.single() && !lambda.empty()) {
      args = lambda[0].split(' ').filter(function(a) {
        return a !== "";
      });
    }
    if (lambda.single()) {
      args = ((_ref = lambda[0].match(/([a-z\_\$][\w\_\$]*)/ig)) != null ? _ref.unique() : void 0) || args;
    }
    lambda = ((_ref1 = lambda.pop()) != null ? _ref1.trim() : void 0) || "";
    variable = lambda.match(/([a-z\_\$][\w\_\$]*)/i) == null ? args[0] : "";
    return eval("(function(" + args + ") { return (" + variable + lambda + "); })");
  };

  String.lambda = String.toFunction = f.lambda = f;

  Function.prototype.lambda = Function.prototype.toFunction = function() {
    return this;
  };

  String.prototype.lambda = String.prototype.toFunction = function() {
    return f(this);
  };

  Function.prototype.c = Function.prototype.curry = function() {
    var args;

    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return f.curry.apply(f, [this.toFunction()].concat(__slice.call(args)));
  };

  f.curry = f.c = function() {
    var args, fn;

    fn = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var args2;

      args2 = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return fn.toFunction().apply(null, __slice.call(args).concat(__slice.call(args2)));
    };
  };

  redefine = function() {
    var alias, aliases, method, _i, _len, _method, _results;

    method = arguments[0], aliases = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    _method = Array.prototype[method];
    aliases.push(method);
    _results = [];
    for (_i = 0, _len = aliases.length; _i < _len; _i++) {
      alias = aliases[_i];
      Array.prototype[alias] = function() {
        var args, fn;

        fn = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return _method.call.apply(_method, [this, fn.toFunction()].concat(__slice.call(args)));
      };
      _results.push(global[alias] = f[alias] = Array[alias] = function() {
        var args, array, fn;

        array = arguments[0], fn = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
        return array[alias].apply(array, [fn.toFunction()].concat(__slice.call(args)));
      });
    }
    return _results;
  };

  redefine('forEach', 'foreach');

  redefine('map');

  redefine('reduce', 'fold', 'foldl');

  redefine('reduceRight', 'foldr');

  redefine('filter');

  redefine('every');

  redefine('some');

  f.concat = Array.concat = function(array, b) {
    return array.concat(b);
  };

  _push = Array.prototype.push;

  Array.prototype.push = function() {
    var args;

    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    _push.call.apply(_push, [this].concat(__slice.call(args)));
    return this;
  };

  global.push = f.push = Array.push = function() {
    var args, array;

    array = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return array.push.apply(array, args);
  };

  if (!Array.prototype.zip) {
    global.zip = f.zip = Array.zip = function() {
      var array, i, length, lengthArray, _i, _results;

      lengthArray = (function() {
        var _i, _len, _results;

        _results = [];
        for (_i = 0, _len = arguments.length; _i < _len; _i++) {
          array = arguments[_i];
          _results.push(array.length);
        }
        return _results;
      }).apply(this, arguments);
      length = f.fold(lengthArray, function(a, b) {
        return Math.min(a, b);
      });
      _results = [];
      for (i = _i = 0; 0 <= length ? _i < length : _i > length; i = 0 <= length ? ++_i : --_i) {
        _results.push((function() {
          var _j, _len, _results1;

          _results1 = [];
          for (_j = 0, _len = arguments.length; _j < _len; _j++) {
            array = arguments[_j];
            _results1.push(array[i]);
          }
          return _results1;
        }).apply(this, arguments));
      }
      return _results;
    };
    Array.prototype.zip = function() {
      return Array.zip.apply(Array, [this].concat(__slice.call(arguments)));
    };
  }

  if (!Array.prototype.unique) {
    global.unique = f.unique = Array.unique = function(array) {
      var element, i, unique, _i, _ref, _results;

      unique = new Object;
      for (i = _i = 0, _ref = array.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        unique[array[i]] = array[i];
      }
      _results = [];
      for (i in unique) {
        element = unique[i];
        _results.push(element);
      }
      return _results;
    };
    Array.prototype.unique = function() {
      return Array.unique(this);
    };
  }

  if (!Array.prototype.dictionary) {
    global.dictionary = f.dictionary = Array.dictionary = function(array, key) {
      return array.reduce((function(d, o) {
        if (o[key] != null) {
          d[o[key]] = o;
        }
        return d;
      }), new Object);
    };
    Array.prototype.dictionary = function(key) {
      return Array.dictionary(this, key);
    };
  }

  if (!Array.prototype.empty) {
    global.empty = f.empty = Array.empty = function(array) {
      return array.length < 1;
    };
    Array.prototype.empty = function() {
      return Array.empty(this);
    };
  }

  if (!Array.prototype.single) {
    Array.prototype.single = function() {
      return this.length === 1;
    };
    global.single = f.single = Array.single = function(array) {
      return array.single();
    };
  }

  if (!Array.prototype.top) {
    global.top = f.top = Array.top = function(array) {
      return array[array.length - 1];
    };
    Array.prototype.top = function() {
      return Array.top(this);
    };
  }

  if (!Array.prototype.remove) {
    global.remove = f.remove = Array.remove = function(array, index) {
      var fn, i;

      if (typeof index === "function") {
        fn = index.toFunction();
        i = 0;
        while (i < array.length) {
          if (fn(array[i], i, array)) {
            array.splice(i, 1);
            i--;
          }
          i++;
        }
      } else {
        array.splice(index, 1);
      }
      return array;
    };
    Array.prototype.remove = function(index) {
      return Array.remove(this, index);
    };
  }

  f.Sequence = (function() {
    Sequence.prototype.formula = null;

    Sequence.prototype.sequence = [];

    Sequence.prototype.set = function(sequence, index) {
      if (index == null) {
        index = 0;
      }
      if (typeof sequence === "function" || typeof sequence === "string") {
        return this.formula = sequence.toFunction();
      } else {
        return this.sequence = (index === 0 ? sequence : this.sequence.map(function(a, i) {
          if (i >= index && i < index + sequence.length) {
            return sequence[i - sequence.length];
          } else {
            return a;
          }
        }));
      }
    };

    Sequence.prototype.get = function(index, size) {
      var i;

      if (size == null) {
        size = 0;
      }
      if (this.formula) {
        if (size === 0) {
          return this.formula.call(this.sequence || this, index);
        }
        return (function() {
          var _i, _results;

          _results = [];
          for (i = _i = 0; 0 <= size ? _i <= size : _i >= size; i = 0 <= size ? ++_i : --_i) {
            _results.push(this.formula.call(this.sequence || this, index + i));
          }
          return _results;
        }).call(this);
      }
      if (size === 0) {
        return this.sequence[index];
      }
      return this.sequence.slice(index, size + 1);
    };

    Sequence.prototype.inverse = function() {
      var _f;

      _f = this.formula;
      return new Sequence(_f ? function(x) {
        return 1 / _f(x);
      } : this.sequence.map('1/x'));
    };

    Sequence.prototype.negative = function() {
      var _f;

      _f = this.formula;
      return new Sequence(_f ? function(x) {
        return -_f(x);
      } : this.sequence.map('-x'));
    };

    function Sequence(sequence) {
      this.set(sequence);
    }

    return Sequence;

  })();

  global.Sequence = f.Sequence;

  f.seq = f.sequence = function(sequence) {
    return new Sequence(sequence);
  };

  Array.prototype.sequence = function() {
    return new Sequence(this);
  };

}).call(this);
