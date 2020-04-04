'use strict';

var Bases$Genetics = require("./Bases.bs.js");

function filter(param) {
  if (param) {
    return Bases$Genetics.to_dna;
  } else {
    return Bases$Genetics.to_rna;
  }
}

function to_string(param) {
  if (param) {
    return "dna";
  } else {
    return "rna";
  }
}

function from_string(param) {
  switch (param) {
    case "dna" :
        return /* DNA */1;
    case "rna" :
        return /* RNA */0;
    default:
      return /* DNA */1;
  }
}

exports.filter = filter;
exports.to_string = to_string;
exports.from_string = from_string;
/* No side effect */
