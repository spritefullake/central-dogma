type effect =
  | Start
  | Stop
  | Nothing;
type table('a) = {
  code1: string,
  code3: string,
  does: effect,
  codon: list('a),
};
let string_to_effect = e =>
  switch (e) {
  | "M" => Start
  | "i" => Start
  | "*" => Stop
  | _ => Nothing
  };
let formatRaw3Code = text =>
  text
  |> Js.String.split("\n")
  |> Array.map(x =>
       Js.String.split("    ", x)
       |> Array.map(x =>
            Js.String.split(" ", x)
            //Remove empty entries
            |> Js.Array.filter(x => x != "")
          )
     )
  //Remove empty arrays
  |> Js.Array.filter(x => x != [|[||]|])
  //Finally flatten the Arrays
  |> Array.fold_left((acc, x) => Array.append(x, acc), [||]);
let parseRow = row =>
  if (Array.length(row) > 3) {
    row[3] |> string_to_effect;
  } else {
    row[1] |> string_to_effect;
  };
let parse3CodeToTable = text =>
  text
  |> Array.map(row => {
       {
         code1: row[1],
         code3: row[2],
         does: parseRow(row),
         codon:
           row[0]
           |> Js.String.replaceByRe([%re "/\\T/g"], "U")
           |> Js.String.split("")
           |> Array.to_list,
       }
     });
let processRaw3Code = text => text |> formatRaw3Code |> parse3CodeToTable;
let raw3CodeURI: string = [%raw {| require("../Codons.tsv").default |}];
open Js.Promise;
let load = () =>
  Fetch.fetch(raw3CodeURI)
  |> then_(Fetch.Response.text)
  |> then_(text => {processRaw3Code(text) |> resolve});