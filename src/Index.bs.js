'use strict';

var React = require("react");
var ReactDOMRe = require("reason-react/src/ReactDOMRe.js");
var Input$Genetics = require("./Input.bs.js");

ReactDOMRe.renderToElementWithId(React.createElement(Input$Genetics.make, {
          name: "Name"
        }), "root");

/*  Not a pure module */
