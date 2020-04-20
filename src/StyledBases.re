[@react.component]
let make = (~strand) => {
  let decideColor = base => {
    switch (base) {
    | "A" => "red"
    | "T"
    | "U" => "yellow"
    | "G" => "blue"
    | "C" => "green"
    | _ => "none"
    };
  };
  let styled =
    strand
    |> Js.String.split("")
    |> Array.map(base => {
         open ReactDOMRe.Style;
         let color = make(~color=decideColor(base), ());
         let base = base |> React.string;
         <span style=color> base </span>;
       })
    |> React.array;
  <p className="base-output"> styled </p>;
};