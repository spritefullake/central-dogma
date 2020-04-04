'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");

function replicate_DNA(param) {
  if (param >= 68) {
    if (param !== 71) {
      if (param !== 84) {
        return ;
      } else {
        return /* A */65;
      }
    } else {
      return /* C */67;
    }
  } else if (param !== 65) {
    if (param >= 67) {
      return /* G */71;
    } else {
      return ;
    }
  } else {
    return /* T */84;
  }
}

function replicate_RNA(param) {
  if (param >= 68) {
    if (param !== 71) {
      if (param !== 85) {
        return ;
      } else {
        return /* A */65;
      }
    } else {
      return /* C */67;
    }
  } else if (param !== 65) {
    if (param >= 67) {
      return /* G */71;
    } else {
      return ;
    }
  } else {
    return /* U */85;
  }
}

function transcribe(param) {
  if (param >= 68) {
    if (param !== 71) {
      if (param !== 84) {
        return ;
      } else {
        return /* A */65;
      }
    } else {
      return /* C */67;
    }
  } else if (param !== 65) {
    if (param >= 67) {
      return /* G */71;
    } else {
      return ;
    }
  } else {
    return /* U */85;
  }
}

function reverse_transcribe(param) {
  if (param >= 68) {
    if (param !== 71) {
      if (param !== 85) {
        return ;
      } else {
        return /* A */65;
      }
    } else {
      return /* C */67;
    }
  } else if (param !== 65) {
    if (param >= 67) {
      return /* G */71;
    } else {
      return ;
    }
  } else {
    return /* T */84;
  }
}

function to_base(param) {
  switch (param) {
    case "A" :
        return /* A */65;
    case "C" :
        return /* C */67;
    case "G" :
        return /* G */71;
    case "T" :
        return /* T */84;
    case "U" :
        return /* U */85;
    default:
      return ;
  }
}

function to_string(param) {
  if (param !== 67) {
    if (param >= 84) {
      if (param >= 85) {
        return "U";
      } else {
        return "T";
      }
    } else if (param >= 71) {
      return "G";
    } else {
      return "A";
    }
  } else {
    return "C";
  }
}

function parse(f, b) {
  return Belt_Option.flatMap(b, f);
}

function display_bases(base) {
  return Belt_Option.mapWithDefault(base, "", to_string);
}

function seq_to_string(f, seq) {
  return $$Array.map((function (x) {
                  var base = Curry._1(f, x);
                  return Belt_Option.mapWithDefault(base, "", to_string);
                }), seq).join("");
}

exports.replicate_DNA = replicate_DNA;
exports.replicate_RNA = replicate_RNA;
exports.transcribe = transcribe;
exports.reverse_transcribe = reverse_transcribe;
exports.to_base = to_base;
exports.to_string = to_string;
exports.parse = parse;
exports.display_bases = display_bases;
exports.seq_to_string = seq_to_string;
/* No side effect */
