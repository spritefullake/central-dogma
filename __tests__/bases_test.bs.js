'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var $$Array = require("bs-platform/lib/js/array.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Bases$Genetics = require("../src/Bases.bs.js");

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

Jest.describe("Replication", (function (param) {
        return Jest.testAll("Correctly replicates single bases of DNA", /* :: */[
                    /* tuple */[
                      "A",
                      "T"
                    ],
                    /* :: */[
                      /* tuple */[
                        "T",
                        "A"
                      ],
                      /* :: */[
                        /* tuple */[
                          "C",
                          "G"
                        ],
                        /* :: */[
                          /* tuple */[
                            "G",
                            "C"
                          ],
                          /* [] */0
                        ]
                      ]
                    ]
                  ], (function (param) {
                      return willBe(param[1], Bases$Genetics.display_replication(param[0]));
                    }));
      }));

Jest.describe("Transcription", (function (param) {
        Jest.testAll("Correctly transcribes DNA to RNA", /* :: */[
              /* tuple */[
                "A",
                "U"
              ],
              /* :: */[
                /* tuple */[
                  "T",
                  "A"
                ],
                /* :: */[
                  /* tuple */[
                    "C",
                    "G"
                  ],
                  /* :: */[
                    /* tuple */[
                      "G",
                      "C"
                    ],
                    /* [] */0
                  ]
                ]
              ]
            ], (function (param) {
                return willBe(param[1], Bases$Genetics.display_transcription(param[0]));
              }));
        Jest.testAll("Erroneous string parsing", /* :: */[
              "!",
              /* :: */[
                "W",
                /* :: */[
                  "\xd9\x87\xd8\xb0\xd8\xa7 \xd8\xba\xd9\x8a\xd8\xb1 \xd8\xb5\xd8\xad\xd9\x8a\xd8\xad",
                  /* [] */0
                ]
              ]
            ], (function (input) {
                return willBe("", Bases$Genetics.display_transcription(input));
              }));
        return Jest.test("DNA base sequences", (function (param) {
                      var bases = "".split("ATGC");
                      var correct = "".split("TACG");
                      return Jest.Expect.toEqual(correct, Jest.Expect.expect($$Array.map(Bases$Genetics.display_transcription, bases)));
                    }));
      }));

Jest.describe("DNA and RNA interactions", (function (param) {
        return Jest.test("reverse transcription reverses transcription", (function (param) {
                      var input = "ATGCGGTAA".split("");
                      return Jest.Expect.toEqual(input, Jest.Expect.expect($$Array.map((function (param) {
                                            if (param !== undefined) {
                                              return Bases$Genetics.to_string(param);
                                            } else {
                                              return "";
                                            }
                                          }), map_opts(Bases$Genetics.reverse_transcribe)(map_opts(Bases$Genetics.transcribe)($$Array.map(Bases$Genetics.to_dna, $$Array.map(Bases$Genetics.to_base, input)))))));
                    }));
      }));

exports.willBe = willBe;
exports.map_opts = map_opts;
/*  Not a pure module */
