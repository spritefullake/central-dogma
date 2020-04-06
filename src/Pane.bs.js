'use strict';

var React = require("react");

function Pane(Props) {
  var title = Props.title;
  var data = Props.data;
  return React.createElement("div", {
              className: "pane"
            }, React.createElement("h3", {
                  className: "pane-title"
                }, title), React.createElement("p", {
                  className: "base-output"
                }, data));
}

var make = Pane;

exports.make = make;
/* react Not a pure module */
