[@react.component]
let make = (~strand, ~colorOn) => {
  let styled =
    strand
    |> Js.String.split("")
    |> Array.map(base => {
        open BasesStyle.Styles;
        <span style={color(colorOn, base)}> {base |> React.string} </span>
       })
    |> React.array;
  <p className="base-output"> styled </p>;
};

