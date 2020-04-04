'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Pane$Genetics = require("./Pane.bs.js");
var Bases$Genetics = require("./Bases.bs.js");
var Chunk$Genetics = require("./Chunk.bs.js");
var NASelect$Genetics = require("./NASelect.bs.js");
var NucleicAcid$Genetics = require("./NucleicAcid.bs.js");

function Input(Props) {
  Props.name;
  var example = $$Array.map((function (x) {
          return x;
        }), [
        /* A */65,
        /* T */84,
        /* G */71,
        /* C */67
      ]);
  var match = React.useState((function () {
          return example;
        }));
  var setSeq = match[1];
  var seq = match[0];
  var updateSeq = function (e) {
    var value = $$Array.map(Bases$Genetics.to_base, e.target.value.toUpperCase().split(""));
    return Curry._1(setSeq, (function (param) {
                  return value;
                }));
  };
  var match$1 = React.useState((function () {
          return /* DNA */1;
        }));
  var setBaseType = match$1[1];
  var baseType = match$1[0];
  var updateBaseType = function (e) {
    var value = NucleicAcid$Genetics.from_string(e.target.value);
    return Curry._1(setBaseType, (function (param) {
                  return value;
                }));
  };
  var processIt = function (f) {
    return $$Array.map(Bases$Genetics.display_bases, $$Array.map(f, seq)).join("");
  };
  var getCodons = function (f) {
    var opt = function (x) {
      return Belt_Option.mapWithDefault(x, "", Bases$Genetics.to_string);
    };
    return $$Array.map((function (x) {
                    return $$Array.map(opt, x).join("");
                  }), $$Array.map($$Array.of_list, $$Array.of_list(Chunk$Genetics.make_codons($$Array.to_list($$Array.map(f, seq)))))).join("--");
  };
  var displayPane = function (baseType) {
    if (baseType) {
      return [
              /* tuple */[
                "Transcribed RNA",
                processIt((function (param) {
                        return Bases$Genetics.parse_dna(Bases$Genetics.transcribe, param);
                      }))
              ],
              /* tuple */[
                "Replicated DNA",
                processIt((function (param) {
                        return Bases$Genetics.parse_dna(Bases$Genetics.replicate_DNA, param);
                      }))
              ],
              /* tuple */[
                "Codons",
                getCodons((function (x) {
                        return Bases$Genetics.parse_dna(Bases$Genetics.transcribe, Bases$Genetics.parse_dna(Bases$Genetics.replicate_DNA, x));
                      }))
              ]
            ];
    } else {
      return [
              /* tuple */[
                "Reverse-transcribed DNA",
                processIt((function (param) {
                        return Bases$Genetics.parse_rna(Bases$Genetics.reverse_transcribe, param);
                      }))
              ],
              /* tuple */[
                "Codons",
                getCodons(Bases$Genetics.to_rna)
              ]
            ];
    }
  };
  var renderPanes = $$Array.map((function (param) {
          var title = param[0];
          return React.createElement(Pane$Genetics.make, {
                      title: title,
                      data: param[1],
                      key: title
                    });
        }), displayPane(baseType));
  return React.createElement(React.Fragment, undefined, React.createElement("label", {
                  htmlFor: "dna"
                }, "Enter the ", React.createElement(NASelect$Genetics.make, {
                      value: baseType,
                      onChange: updateBaseType
                    }), " sequence"), React.createElement("br", undefined), React.createElement("input", {
                  id: "dna",
                  placeholder: "Enter the sequence",
                  value: $$Array.map(Bases$Genetics.display_bases, seq).join(""),
                  onChange: updateSeq
                }), renderPanes);
}

var make = Input;

exports.make = make;
/* react Not a pure module */
