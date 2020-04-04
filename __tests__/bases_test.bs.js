'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var $$Array = require("bs-platform/lib/js/array.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");

function willBe(x, y) {
  return Jest.Expect.toBe(y, Jest.Expect.expect(x));
}

function map_opts(f) {
  return (function (param) {
      return $$Array.map((function (i) {
                    return Belt_Option.map(i, f);
                  }), param);
    });
}

exports.willBe = willBe;
exports.map_opts = map_opts;
/* Jest Not a pure module */
