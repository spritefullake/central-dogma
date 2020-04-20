[@react.component]
let make = (~strand, ~baseType) => {
  let (codonSource, setCodonSource) = React.useState(() => ([||] :> Codons.table));
  React.useEffect0(() => {
    open Js.Promise;
    LoadCodons.load()
    |> then_(res => setCodonSource(_ => res) |> resolve)
    |> ignore;
    None;
  });
  open PaneData;
  let renderPanes =
    displayPane(~strand, ~backbone=baseType, ~source=codonSource)
    |> Array.map(({title, data, colorOn}) => <Pane key=title title data colorOn />);

  <div id="output"> {renderPanes |> React.array} </div>;
};