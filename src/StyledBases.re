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
  let colorBases = (index, bases) => {
    switch (bases) {
    | [] => React.string("")
    | [base, ..._] =>
      let style = Styles.color(colorOn, base);
      let key = index |> string_of_int;
      let content =
        bases |> Array.of_list |> Js.Array.joinWith("") |> React.string;
      <span style key> content </span>;
    };
  };

  let bases = () =>
    Js.String.split("", strand)
    |> Array.to_list
    |> Chunk.group_by_order((x, y) => x == y);
  let styled = () =>
    colorBases->List.mapi(bases())->Array.of_list->React.array;

  <p className="base-output">
    {colorOn ? styled() : React.string(strand)}
  </p>;
};