'use strict';

var React = require("react");
var NucleicAcid$Genetics = require("./NucleicAcid.bs.js");

function NASelect(Props) {
  var value = Props.value;
  var onChange = Props.onChange;
  return React.createElement("select", {
              id: "nucleic-acid-type",
              value: NucleicAcid$Genetics.to_string(value),
              onChange: onChange
            }, React.createElement("option", {
                  value: NucleicAcid$Genetics.to_string(/* DNA */1)
                }, "DNA"), React.createElement("option", {
                  value: NucleicAcid$Genetics.to_string(/* RNA */0)
                }, "RNA"));
}

var make = NASelect;

exports.make = make;
/* react Not a pure module */
