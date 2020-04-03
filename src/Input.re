open Bases;
open Chunk;
[@react.component]
let make = (~name) => {
  let (seq, setSeq) = React.useState(() => "ATGC");
  let updateSeq = e => e->ReactEvent.Form.target##value->setSeq;
  let processIt = f => {
    seq
    |> Js.String.toUpperCase
    |> Js.String.split("")
    |> Array.map(f)
    |> Js.Array.joinWith("");
  };

  let displayPane = [|
    ("Transcribed RNA", display_transcription),
    ("Replicated DNA", display_replication),
    ("Reverse-transcribed DNA", display_reverse_transcription),
    ("Codons", (x) => x)
  |];

  let renderPanes =
    displayPane
    |> Array.map(((title, f)) => <Pane title data={processIt(f)} />);

  <>
    <label htmlFor="dna">
      {"Enter the " |> React.string}
      <NASelect />
      {" sequence" |> React.string}
    </label>
    <br/>
    <input
      id="dna"
      placeholder="Enter the sequence"
      value=seq
      onChange=updateSeq
    />
    {renderPanes |> React.array}
  </>;
};