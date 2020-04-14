open Bases;
open Codons;
open NucleicAcid;
open Polymerase;

[@react.component]
let make = () => {
  let (baseType, setBaseType) = React.useState(() => DNA);
  let updateBaseType = e => {
    let value = e->ReactEvent.Form.target##value->from_string;
    setBaseType(_ => value);
  };
  let (seq, setSeq) = React.useState(() => [||]);
  let updateSeq = e => {
    let filterBaseType = x => choose(x, baseType);
    //Ensure only valid base inputs are accepted
    let value =
      e->ReactEvent.Form.target##value
      |> Js.String.toUpperCase
      |> Js.String.split("")
      |> Array.map(letter => letter |> to_base >>= filterBaseType);
    setSeq(_ => value);
  };


  let toCodons = input => {
    input |> Js.String.split("") |> make_codons |> Js.Array.joinWith("--");
  };

  let process = seq |> parse_then_string;

  let displayPane = baseType =>
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
        ("Codons", strand_to_string(seq) |> toCodons),
        ("Anticodons", process(rna_polymerase) |> toCodons),
      |]
    };
  let renderPanes =
    displayPane(baseType)
    |> Array.map(((title, f)) => <Pane key=title title data=f />);
  <>
    <label htmlFor="dna">
      {"Enter the " |> React.string}
      <NASelect value=baseType onChange=updateBaseType />
      {" template strand" |> React.string}
    </label>
    <input
      id="dna"
      placeholder="Enter the template strand sequence"
      value={ strand_to_string(seq)}
      onChange=updateSeq
    />
    {renderPanes |> React.array}
  </>;
};