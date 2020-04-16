open Codons;
open NucleicAcid;
open Bases;
let toCodons = input =>
  input
  |> Js.String.split("")
  |> make_codons
  |> display_codons
  |> Js.Array.joinWith("--");
let toAACode = (~code, ~source, input) => {
  let modified = input |> Js.String.split("");
  match_codons(~input=modified, ~source, ~letter_code=code)
  |> display_matches
  |> Js.Array.joinWith("--");
};
open Polymerase;
let displayPane = (~strand, ~source, ~backbone) => {
  let process = strand |> parse_then_string;
  switch (backbone) {
  | DNA => [|
      ("Transcribed RNA", process(rna_polymerase)),
      ("Replicated DNA", process(dna_polymerase)),
      ("Codons", process(rna_polymerase) |> toCodons),
      (
        "Anticodons",
        process(x => x |> rna_polymerase >>= reverse_transcriptase) |> toCodons,
      ),
      (
        "Amino Acids (One Letter Code)",
        process(rna_polymerase) |> toAACode(~source, ~code=`One),
      ),
      (
        "Amino Acids (Three Letter Code)",
        process(rna_polymerase) |> toAACode(~source, ~code=`Three),
      ),
    |]
  | RNA => [|
      ("Reverse-transcribed DNA", process(reverse_transcriptase)),
      ("Codons", strand_to_string(strand) |> toCodons),
      ("Anticodons", process(rna_polymerase) |> toCodons),
      (
        "Amino Acids (One Letter Code)",
        strand_to_string(strand) |> toAACode(~source, ~code=`One),
      ),
      (
        "Amino Acids (Three Letter Code)",
        process(rna_polymerase) |> toAACode(~source, ~code=`Three),
      ),
    |]
  };
};