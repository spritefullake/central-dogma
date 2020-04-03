'use strict';

var List = require("bs-platform/lib/js/list.js");
var $$String = require("bs-platform/lib/js/string.js");

function chunk(size, input) {
  var loop = function (_acc, _input) {
    while(true) {
      var input = _input;
      var acc = _acc;
      if (input === "") {
        return acc;
      } else if (input.length <= size) {
        return /* :: */[
                input,
                acc
              ];
      } else {
        var head = $$String.sub(input, 0, size);
        var remaining = input.length - size | 0;
        var tail = $$String.sub(input, size, remaining);
        _input = tail;
        _acc = /* :: */[
          head,
          acc
        ];
        continue ;
      }
    };
  };
  return List.rev(loop(/* [] */0, input));
}

function take(size, input) {
  var loop = function (input, size) {
    if (input && size !== 0) {
      return /* :: */[
              input[0],
              loop(input[1], size - 1 | 0)
            ];
    } else {
      return /* [] */0;
    }
  };
  return loop(input, size);
}

function drop(size, input) {
  var _input = input;
  var _size = size;
  while(true) {
    var size$1 = _size;
    var input$1 = _input;
    if (input$1 && size$1 !== 0) {
      _size = size$1 - 1 | 0;
      _input = input$1[1];
      continue ;
    } else {
      return input$1;
    }
  };
}

function chunk_list(size, input) {
  var loop = function (_acc, _list) {
    while(true) {
      var list = _list;
      var acc = _acc;
      if (List.length(list) <= size) {
        return /* :: */[
                list,
                acc
              ];
      } else {
        var elem = take(size, list);
        _list = drop(size, list);
        _acc = /* :: */[
          elem,
          acc
        ];
        continue ;
      }
    };
  };
  return List.rev(loop(/* [] */0, input));
}

function make_codons(input) {
  return chunk_list(3, input);
}

exports.chunk = chunk;
exports.take = take;
exports.drop = drop;
exports.chunk_list = chunk_list;
exports.make_codons = make_codons;
/* No side effect */
