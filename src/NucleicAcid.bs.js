'use strict';


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

function to_rna(base) {
  if (base !== undefined) {
    var match = base;
    if (match >= 68) {
      if (match !== 71 && match !== 85) {
        return ;
      } else {
        return base;
      }
    } else if (match !== 65 && match < 67) {
      return ;
    } else {
      return base;
    }
  }
  
}

function to_dna(base) {
  if (base !== undefined) {
    var match = base;
    if (match >= 68) {
      if (match !== 71 && match !== 84) {
        return ;
      } else {
        return base;
      }
    } else if (match !== 65 && match < 67) {
      return ;
    } else {
      return base;
    }
  }
  
}

function decide_parse(param) {
  if (param) {
    return to_dna;
  } else {
    return to_rna;
  }
}

exports.to_string = to_string;
exports.from_string = from_string;
exports.to_rna = to_rna;
exports.to_dna = to_dna;
exports.decide_parse = decide_parse;
/* No side effect */
