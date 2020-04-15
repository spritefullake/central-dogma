type effect =
  | Start
  | Stop
  | Nothing;
type table('a) = {
  aminoAcid: string,
  does: effect,
  codon: list('a),
};
let string_to_effect = e =>
  switch (e) {
  | "M" => Start
  | "*" => Stop
  | _ => Nothing
  };
let reshape = line => {
  let columns = Js.String.split("=", line) |> Array.map(Js.String.trim);
  let _heading = columns[0];
  let value = columns[1] |> Js.String.split("");
  value;
};
let rawTable: string = [%raw {| require("../CodonsShort.txt").default |}];
let lines = Js.String.split("\n", rawTable);

let matrix = lines |> Array.map(reshape);

let new_matrix =
  "" |> Array.make_matrix(matrix[0] |> Array.length, matrix |> Array.length);
for (i in 0 to (matrix |> Array.length) - 1) {
  let row = matrix[i];
  for (j in 0 to (row |> Array.length) - 1) {
    let entry = matrix[i][j];
    /* Replace Thymine with Uracil because
     * RNA codons are less confusing
     * than DNA codons
     */
    if (i >= 2 && entry == "T") {
      new_matrix[j][i] = "U";
    } else {
      new_matrix[j][i] = entry;
    };
  };
};

let formatRaw3Code = text => text 
  |> Js.String.split("\n")
  |> Array.map (x => 
    Js.String.split("    ",x) 
    |> Array.map (x => Js.String.split(" ",x)
      //Remove empty entries
      |> Js.Array.filter (x => x != "")))
  //Remove empty arrays
  |> Js.Array.filter (x => x != [| [||] |])
  //Finally flatten the Arrays
  |> Array.fold_left((acc, x) => Array.append(x,acc),[||])

let raw3CodeURI: string = [%raw {| require("../Codons.tsv").default |}];
Js.Promise.(
  Fetch.fetch(raw3CodeURI)
  |> then_(Fetch.Response.text)
  |> then_(text => text 
    |> formatRaw3Code 
    |> Js.log
    |> resolve
  )
);

let codonsTable =
  Array.map(
    row => {
      {
        aminoAcid: row[0],
        does: row[1] |> string_to_effect,
        codon: [row[2], row[3], row[4]],
      }
    },
    new_matrix,
  );