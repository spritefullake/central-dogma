open Bases;
open Codons;
open NucleicAcid;

[@react.component]
let make = () => {
  let (baseType, setBaseType) = React.useState(() => DNA);
  let updateBaseType = e => {
    let value = e->ReactEvent.Form.target##value->from_string;
    setBaseType(_ => value);
  };

  let (seq, setSeq) = React.useState(() => [||]);
  let updateSeq = e => {
    //Ensure only valid base inputs are accepted
    let value =
      e->ReactEvent.Form.target##value
      |> Js.String.toUpperCase
      |> Js.String.split("")
      |> Array.map(to_base)
      |> Array.map(NucleicAcid.filter(baseType));
    setSeq(_ => value);
  };

  let getCodons = f => {
    seq
    |> Array.map(f)
    |> make_codons
    |> Js.Array.joinWith("--");
  };

  let displayPane = baseType =>
    switch (baseType) {
    | DNA => [|
        ("Transcribed RNA", parse_dna(transcribe)->seq_to_string(seq)),
        ("Replicated DNA", parse_dna(replicate_DNA)->seq_to_string(seq)),
        (
          "Codons",
          (x => parse_dna(replicate_DNA, x) |> parse_dna(transcribe))
          |> getCodons,
        ),
      |]
    | RNA => [|
        (
          "Reverse-transcribed DNA",
          parse_rna(reverse_transcribe)->seq_to_string(seq),
        ),
        ("Codons", to_rna |> getCodons),
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
    <br />
    <input
      id="dna"
      placeholder="Enter the template strand sequence"
      value={seq |> Array.map(display_bases) |> Js.Array.joinWith("")}
      onChange=updateSeq
    />
    {renderPanes |> React.array}
  </>;
};