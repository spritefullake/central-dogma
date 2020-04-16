open Codons;
open NucleicAcid;
open Polymerase;
open Bases;
type tableType = array(LoadCodons.table(string));
[@react.component]
let make = (~strand, ~baseType) => {
  let (codonSource, setCodonSource) =
    React.useState(() => ([||] :> tableType));

  React.useEffect0(() => {
    open Js.Promise;
    LoadCodons.load()
    |> then_(res => setCodonSource(_ => res) |> Js.log2(res) |> resolve)
    |> ignore;
    None;
  });

  let toCodons = input =>
    input
    |> Js.String.split("")
    |> make_codons
    |> display_codons
    |> Js.Array.joinWith("--");

  let toAACode = (~code, input) => {
    let modified = input |> Js.String.split("");
    match_codons(~input=modified, ~source=codonSource, ~letter_code=code)
    |> display_matches
    |> Js.Array.joinWith("--");
  };

  let process = strand |> parse_then_string;
  let displayPane =
    switch (baseType) {
    | DNA => [|
        ("Transcribed RNA", process(rna_polymerase)),
        ("Replicated DNA", process(dna_polymerase)),
        ("Codons", process(rna_polymerase) |> toCodons),
        (
          "Anticodons",
          process(x => x |> rna_polymerase >>= reverse_transcriptase)
          |> toCodons,
        ),
        (
          "Amino Acids (One Letter Code)",
          process(rna_polymerase) |> toAACode(~code=`One),
        ),
        (
          "Amino Acids (Three Letter Code)",
          process(rna_polymerase) |> toAACode(~code=`Three),
        ),
      |]
    | RNA => [|
        ("Reverse-transcribed DNA", process(reverse_transcriptase)),
        ("Codons", strand_to_string(strand) |> toCodons),
        ("Anticodons", process(rna_polymerase) |> toCodons),
        (
          "Amino Acids (One Letter Code)",
          strand_to_string(strand) |> toAACode(~code=`One),
        ),
        (
          "Amino Acids (Three Letter Code)",
          process(rna_polymerase) |> toAACode(~code=`Three),
        ),
      |]
    };
  let renderPanes =
    displayPane |> Array.map(((title, f)) => <Pane key=title title data=f />);

  <div> {renderPanes |> React.array} </div>;
};