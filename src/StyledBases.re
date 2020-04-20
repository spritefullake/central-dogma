module Styles = {
  open Css;

  let decideColor =
    fun
    | "A" => red
    | "T"
    | "U" => yellow
    | "C" => green
    | "G" => blue
    | _ => white;

  let toggle = base =>
    fun
    | true => decideColor(base)
    | false => white;

  let color = (base, color_on) => 
    [toggle(color_on, base) |> color] |> style;

};

[@react.component]
let make = (~strand, ~colorOn) => {
  let styled =
    strand
    |> Js.String.split("")
    |> Array.map(base => {
        let style = Styles.color(colorOn, base);
        <span style> {base |> React.string} </span>
       })
    |> React.array;
  <p className="base-output"> styled </p>;
};