'use strict';

var $$String = require("bs-platform/lib/js/string.js");
var Caml_array = require("bs-platform/lib/js/caml_array.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");

function replicate_DNA(param) {
  if (param >= 71) {
    if (param >= 84) {
      return /* A */65;
    } else {
      return /* C */67;
    }
  } else if (param >= 67) {
    return /* G */71;
  } else {
    return /* T */84;
  }
}

function replicate_RNA(param) {
  if (param >= 71) {
    if (param >= 85) {
      return /* A */65;
    } else {
      return /* C */67;
    }
  } else if (param >= 67) {
    return /* G */71;
  } else {
    return /* U */85;
  }
}

function transcribe(param) {
  if (param >= 71) {
    if (param >= 84) {
      return /* A */65;
    } else {
      return /* C */67;
    }
  } else if (param >= 67) {
    return /* G */71;
  } else {
    return /* U */85;
  }
}

function reverse_transcribe(param) {
  if (param >= 71) {
    if (param >= 85) {
      return /* A */65;
    } else {
      return /* C */67;
    }
  } else if (param >= 67) {
    return /* G */71;
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

function to_dna(x) {
  if (x !== undefined) {
    var match = x;
    if (match >= 68) {
      if (match !== 71 && match !== 84) {
        return ;
      } else {
        return x;
      }
    } else if (match !== 65 && match < 67) {
      return ;
    } else {
      return x;
    }
  }
  
}

function to_rna(x) {
  if (x !== undefined) {
    var match = x;
    if (match >= 68) {
      if (match !== 71 && match !== 85) {
        return ;
      } else {
        return x;
      }
    } else if (match !== 65 && match < 67) {
      return ;
    } else {
      return x;
    }
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

function parse_dna(f, letter) {
  return Belt_Option.map(to_dna(to_base(letter)), f);
}

function parse_rna(f, letter) {
  return Belt_Option.map(to_rna(to_base(letter)), f);
}

function display_transcription(letter) {
  return Belt_Option.mapWithDefault(parse_dna(transcribe, letter), "", to_string);
}

function display_reverse_transcription(letter) {
  return Belt_Option.mapWithDefault(parse_rna(reverse_transcribe, letter), "", to_string);
}

function display_replication(letter) {
  return Belt_Option.mapWithDefault(parse_dna(replicate_DNA, letter), "", to_string);
}

function $$process(input) {
  var length = input.length;
  var result = Caml_array.caml_make_vect(length, "");
  for(var i = 0 ,i_finish = length - 1 | 0; i <= i_finish; ++i){
    Caml_array.caml_array_set(result, i, $$String.sub(input, i, 1));
  }
  return result;
}

exports.replicate_DNA = replicate_DNA;
exports.replicate_RNA = replicate_RNA;
exports.transcribe = transcribe;
exports.reverse_transcribe = reverse_transcribe;
exports.to_base = to_base;
exports.to_dna = to_dna;
exports.to_rna = to_rna;
exports.to_string = to_string;
exports.parse_dna = parse_dna;
exports.parse_rna = parse_rna;
exports.display_transcription = display_transcription;
exports.display_reverse_transcription = display_reverse_transcription;
exports.display_replication = display_replication;
exports.$$process = $$process;
/* No side effect */
