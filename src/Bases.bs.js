'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
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

function parse_dna(f, base) {
  return Belt_Option.map(to_dna(base), f);
}

function parse_rna(f, base) {
  return Belt_Option.map(to_rna(base), f);
}

function parse_str_dna(f, letter) {
  return Belt_Option.map(to_dna(to_base(letter)), f);
}

function parse_str_rna(f, letter) {
  return Belt_Option.map(to_rna(to_base(letter)), f);
}

function display_bases(base) {
  return Belt_Option.mapWithDefault(base, "", to_string);
}

function display_transcription(letter) {
  return Belt_Option.mapWithDefault(parse_str_dna(transcribe, letter), "", to_string);
}

function display_reverse_transcription(letter) {
  return Belt_Option.mapWithDefault(parse_str_rna(reverse_transcribe, letter), "", to_string);
}

function display_replication(letter) {
  return Belt_Option.mapWithDefault(parse_str_dna(replicate_DNA, letter), "", to_string);
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
exports.to_dna = to_dna;
exports.to_rna = to_rna;
exports.to_string = to_string;
exports.parse_dna = parse_dna;
exports.parse_rna = parse_rna;
exports.parse_str_dna = parse_str_dna;
exports.parse_str_rna = parse_str_rna;
exports.display_bases = display_bases;
exports.display_transcription = display_transcription;
exports.display_reverse_transcription = display_reverse_transcription;
exports.display_replication = display_replication;
exports.seq_to_string = seq_to_string;
/* No side effect */
