'use strict';

var React = require("react");

function NASelect(Props) {
  return React.createElement("select", {
              id: "nucleic-acid-type"
            }, React.createElement("option", {
                  value: "dna"
                }, "DNA"), React.createElement("option", {
                  value: "rna"
                }, "RNA"));
}

var make = NASelect;

exports.make = make;
/* react Not a pure module */
