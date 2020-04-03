'use strict';

var React = require("react");

function Pane(Props) {
  var title = Props.title;
  var data = Props.data;
  return React.createElement("div", undefined, React.createElement("h3", undefined, title), React.createElement("p", undefined, data));
}

var make = Pane;

exports.make = make;
/* react Not a pure module */
