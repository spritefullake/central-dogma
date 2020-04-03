'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var Chunk$Genetics = require("../src/Chunk.bs.js");

Jest.describe("Chunking", (function (param) {
        Jest.test("Single Chunk", (function (param) {
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
        return Jest.test("Codon Chunking", (function (param) {
                      var result = Chunk$Genetics.make_codons(/* :: */[
                            "A",
                            /* :: */[
                              "T",
                              /* :: */[
                                "G",
                                /* :: */[
                                  "C",
                                  /* :: */[
                                    "A",
                                    /* :: */[
                                      "G",
                                      /* :: */[
                                        "T",
                                        /* :: */[
                                          "T",
                                          /* :: */[
                                            "T",
                                            /* [] */0
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]);
                      return Jest.Expect.toEqual(/* :: */[
                                  /* :: */[
                                    "A",
                                    /* :: */[
                                      "T",
                                      /* :: */[
                                        "G",
                                        /* [] */0
                                      ]
                                    ]
                                  ],
                                  /* :: */[
                                    /* :: */[
                                      "C",
                                      /* :: */[
                                        "A",
                                        /* :: */[
                                          "G",
                                          /* [] */0
                                        ]
                                      ]
                                    ],
                                    /* :: */[
                                      /* :: */[
                                        "T",
                                        /* :: */[
                                          "T",
                                          /* :: */[
                                            "T",
                                            /* [] */0
                                          ]
                                        ]
                                      ],
                                      /* [] */0
                                    ]
                                  ]
                                ], Jest.Expect.expect(result));
                    }));
      }));

/*  Not a pure module */
