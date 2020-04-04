'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var Chunk$Genetics = require("../src/Chunk.bs.js");

Jest.describe("Chunking", (function (param) {
        return Jest.test("Single Chunk", (function (param) {
                      var result = Chunk$Genetics.chunk(1, "This");
                      return Jest.Expect.toEqual(/* :: */[
                                  "T",
                                  /* :: */[
                                    "h",
                                    /* :: */[
                                      "i",
                                      /* :: */[
                                        "s",
                                        /* [] */0
                                      ]
                                    ]
                                  ]
                                ], Jest.Expect.expect(result));
                    }));
      }));

/*  Not a pure module */
