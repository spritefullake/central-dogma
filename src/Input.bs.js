'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Pane$Genetics = require("./Pane.bs.js");
var Bases$Genetics = require("./Bases.bs.js");
var Codons$Genetics = require("./Codons.bs.js");
var NASelect$Genetics = require("./NASelect.bs.js");
var NucleicAcid$Genetics = require("./NucleicAcid.bs.js");

function Input(Props) {
  var match = React.useState((function () {
          return /* DNA */1;
        }));
  var setBaseType = match[1];
  var baseType = match[0];
  var updateBaseType = function (e) {
    var value = NucleicAcid$Genetics.from_string(e.target.value);
    return Curry._1(setBaseType, (function (param) {
                  return value;
                }));
  };
  var match$1 = React.useState((function () {
          return [];
        }));
  var setSeq = match$1[1];
  var seq = match$1[0];
  var updateSeq = function (e) {
    var value = $$Array.map(Bases$Genetics.to_base, e.target.value.toUpperCase().split(""));
    return Curry._1(setSeq, (function (param) {
                  return value;
                }));
  };
  var getCodons = function (f) {
    return Codons$Genetics.make_codons($$Array.map(f, seq)).join("--");
  };
  var displayPane = function (baseType) {
    if (baseType) {
      return [
              /* tuple */[
                "Transcribed RNA",
                Bases$Genetics.seq_to_string((function (param) {
                        return Bases$Genetics.parse(Bases$Genetics.transcribe, param);
                      }), seq)
              ],
              /* tuple */[
                "Replicated DNA",
                Bases$Genetics.seq_to_string((function (param) {
                        return Bases$Genetics.parse(Bases$Genetics.replicate_DNA, param);
                      }), seq)
              ],
              /* tuple */[
                "Codons",
                getCodons((function (x) {
                        return Bases$Genetics.parse(Bases$Genetics.transcribe, Bases$Genetics.parse(Bases$Genetics.replicate_DNA, x));
                      }))
              ]
            ];
    } else {
      return [
              /* tuple */[
                "Reverse-transcribed DNA",
                Bases$Genetics.seq_to_string((function (param) {
                        return Bases$Genetics.parse(Bases$Genetics.reverse_transcribe, param);
                      }), seq)
              ],
              /* tuple */[
                "Codons",
                getCodons((function (x) {
                        return x;
                      }))
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
                    }), " template strand"), React.createElement("input", {
                  id: "dna",
                  placeholder: "Enter the template strand sequence",
                  value: $$Array.map(Bases$Genetics.display_bases, seq).join(""),
                  onChange: updateSeq
                }), renderPanes);
}

var make = Input;

exports.make = make;
/* react Not a pure module */
