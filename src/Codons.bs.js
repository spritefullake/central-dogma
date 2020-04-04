'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Bases$Genetics = require("./Bases.bs.js");
var Chunk$Genetics = require("./Chunk.bs.js");

function make_codons(input) {
  var opt = function (x) {
    return Belt_Option.mapWithDefault(x, "", Bases$Genetics.to_string);
  };
  return $$Array.map((function (x) {
                return $$Array.map(opt, x).join("");
              }), $$Array.map($$Array.of_list, $$Array.of_list(Chunk$Genetics.chunk_list(3, $$Array.to_list(input)))));
}

exports.make_codons = make_codons;
/* No side effect */
