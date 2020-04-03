'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Pane$Genetics = require("./Pane.bs.js");
var Bases$Genetics = require("./Bases.bs.js");
var NASelect$Genetics = require("./NASelect.bs.js");

function Input(Props) {
  Props.name;
  var match = React.useState((function () {
          return "ATGC";
        }));
  var setSeq = match[1];
  var seq = match[0];
  var updateSeq = function (e) {
    return Curry._1(setSeq, e.target.value);
  };
  var processIt = function (f) {
    return $$Array.map(f, seq.toUpperCase().split("")).join("");
  };
  var displayPane = [
    /* tuple */[
      "Transcribed RNA",
      Bases$Genetics.display_transcription
    ],
    /* tuple */[
      "Replicated DNA",
      Bases$Genetics.display_replication
    ],
    /* tuple */[
      "Reverse-transcribed DNA",
      Bases$Genetics.display_reverse_transcription
    ],
    /* tuple */[
      "Codons",
      (function (x) {
          return x;
        })
    ]
  ];
  var renderPanes = $$Array.map((function (param) {
          return React.createElement(Pane$Genetics.make, {
                      title: param[0],
                      data: processIt(param[1])
                    });
        }), displayPane);
  return React.createElement(React.Fragment, undefined, React.createElement("label", {
                  htmlFor: "dna"
                }, "Enter the ", React.createElement(NASelect$Genetics.make, { }), " sequence"), React.createElement("br", undefined), React.createElement("input", {
                  id: "dna",
                  placeholder: "Enter the sequence",
                  value: seq,
                  onChange: updateSeq
                }), renderPanes);
}

var make = Input;

exports.make = make;
/* react Not a pure module */
