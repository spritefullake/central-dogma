open Codons;
open NucleicAcid;
open Polymerase;
open Bases;
[@react.component]
let make = (~strand, ~baseType) => {
  let toCodons = input => {
    input |> Js.String.split("") |> make_codons |> Js.Array.joinWith("--");
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
      |]
    | RNA => [|
        ("Reverse-transcribed DNA", process(reverse_transcriptase)),
        ("Codons", strand_to_string(strand) |> toCodons),
        ("Anticodons", process(rna_polymerase) |> toCodons),
      |]
    };
  let renderPanes =
    displayPane
    |> Array.map(((title, f)) => <Pane key=title title data=f />);
  
  <div>
    {renderPanes |> React.array}
  </div>;
}