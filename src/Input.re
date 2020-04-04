open Bases;
open Chunk;
open NucleicAcid;

[@react.component]
let make = (~name) => {
  let example = [|`A, `T, `G, `C|] |> Array.map(x => Some(x));
  let (seq, setSeq) = React.useState(() => example);
  let updateSeq = e => {
    let value =
      e->ReactEvent.Form.target##value
      |> Js.String.toUpperCase
      |> Js.String.split("")
      |> Array.map(to_base);
    setSeq(_ => value);
  };

  let (baseType, setBaseType) = React.useState(() => DNA);
  let updateBaseType = e => {
    let value = e->ReactEvent.Form.target##value->from_string;
    setBaseType(_ => value);
  };

  let processIt = f => {
    seq |> Array.map(f) |> Array.map(display_bases) |> Js.Array.joinWith("");
  };

  let getCodons = f => {
    let opt = x => Belt.Option.mapWithDefault(x, "", Bases.to_string);
    seq
    |> Array.map(f)
    |> Array.to_list
    |> make_codons
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map(x => x |> Array.map(opt) |> Js.Array.joinWith(""))
    |> Js.Array.joinWith("--");
  };
  //|> Array.map(x => x |> Js.Array.joinWith(""))

  let displayPane = baseType =>
    switch (baseType) {
    | DNA => [|
        ("Transcribed RNA", parse_dna(transcribe) |> processIt),
        ("Replicated DNA", parse_dna(replicate_DNA) |> processIt),
        (
          "Codons",
          (x => x |> parse_dna(replicate_DNA) |> parse_dna(transcribe))
          |> getCodons,
        ),
      |]
    | RNA => [|
        (
          "Reverse-transcribed DNA",
          parse_rna(reverse_transcribe) |> processIt,
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
      {" sequence" |> React.string}
    </label>
    <br />
    <input
      id="dna"
      placeholder="Enter the sequence"
      value={seq |> Array.map(display_bases) |> Js.Array.joinWith("")}
      onChange=updateSeq
    />
    {renderPanes |> React.array}
  </>;
};