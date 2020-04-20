open Codons;
open NucleicAcid;
open Bases;
let toCodons = input =>
  input
  |> Js.String.split("")
  |> Array.to_list
  |> make_codons
  |> display_codons
  |> Js.Array.joinWith("--");
let toAACode = (~code, ~source, input) => {
  let modified = input |> Js.String.split("") |> Array.to_list;
  match_codons(~input=modified, ~source, ~letter_code=code)
  |> display_matches
  |> Js.Array.joinWith("--");
};
type t = {
  title: string,
  data: string,
  colorOn: bool,
};
let t_of_tuple = ((title, data, colorOn)) => {title, data, colorOn};
open Polymerase;
let displayPane = (~strand, ~source, ~backbone, ~colorBases) => {
  let process = strand |> parse_then_string;
  let dnaPane = [|
    ("Transcribed RNA", process(rna_polymerase), colorBases),
    ("Replicated DNA", process(dna_polymerase), colorBases),
    ("Codons", process(rna_polymerase) |> toCodons, colorBases),
    (
      "Anticodons",
      process(x => x |> rna_polymerase >>= reverse_transcriptase) |> toCodons,
      colorBases,
    ),
    (
      "Amino Acids (One Letter Code)",
      process(rna_polymerase) |> toAACode(~source, ~code=`One),
      false,
    ),
    (
      "Amino Acids (Three Letter Code)",
      process(rna_polymerase) |> toAACode(~source, ~code=`Three),
      false,
    ),
  |];
  let rnaPane = [|
    ("Reverse-transcribed DNA", process(reverse_transcriptase), colorBases),
    ("Codons", strand_to_string(strand) |> toCodons, colorBases),
    ("Anticodons", process(rna_polymerase) |> toCodons, colorBases),
    (
      "Amino Acids (One Letter Code)",
      strand_to_string(strand) |> toAACode(~source, ~code=`One),
      false,
    ),
    (
      "Amino Acids (Three Letter Code)",
      strand_to_string(strand) |> toAACode(~source, ~code=`Three),
      false,
    ),
  |];
  switch (backbone) {
  | DNA => dnaPane |> Array.map(t_of_tuple)
  | RNA => rnaPane |> Array.map(t_of_tuple)
  };
};