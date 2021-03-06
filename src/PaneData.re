open Codons;
open NucleicAcid;
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

let displayPane =
    (~strand: array(string), ~source, ~backbone, ~colorBases) => {
  //let process = strand |> parse_then_string;
  open Enzyme.Poly;
  let process = s => s |> Enzyme.Poly.to_string |> Js.Array.joinWith("");
  let dnaPane = strand => {
    
    let s = strand |> Array.map(Enzyme.Poly.from_string) |> toDNA 
    let transcribedRNA = transcribe(s) |> process;
    let replicatedDNA = replicate(s) |> process;
    let codons = transcribe(s) |> process |> toCodons;
    let anticodons =
      transcribe(s) |> reverse_transcribe |> process |> toCodons;
    let aminoAcids = transcribe(s) |> process;
    let aminoAcids1 = aminoAcids |> toAACode(~source, ~code=`One);
    let aminoAcids3 = aminoAcids |> toAACode(~source, ~code=`Three);
    [|
      ("Transcribed RNA", transcribedRNA, colorBases),
      ("Replicated DNA", replicatedDNA, colorBases),
      ("Codons", codons, colorBases),
      ("Anticodons", anticodons, colorBases),
      ("Amino Acids (One Letter Code)", aminoAcids1, false),
      ("Amino Acids (Three Letter Code)", aminoAcids3, false),
    |];
  };
  let rnaPane = strand => {
    let s = strand |> Array.map(Enzyme.Poly.from_string) |> toRNA;
    let reverseTranscribedDNA = reverse_transcribe(s) |> process;
    let codons = process(s) |> toCodons;
    let anticodons = reverseTranscribedDNA |> toCodons;
    let aminoAcids1 = process(s) |> toAACode(~source, ~code=`One);
    let aminoAcids3 = process(s) |> toAACode(~source, ~code=`Three);
    [|
      ("Reverse-transcribed DNA", reverseTranscribedDNA, colorBases),
      ("Codons", codons, colorBases),
      ("Anticodons", anticodons, colorBases),
      ("Amino Acids (One Letter Code)", aminoAcids1, false),
      ("Amino Acids (Three Letter Code)", aminoAcids3, false),
    |];
  };
  switch (backbone) {
  | DNA => dnaPane(strand) |> Array.map(t_of_tuple)
  | RNA => rnaPane(strand) |> Array.map(t_of_tuple)
  };
};