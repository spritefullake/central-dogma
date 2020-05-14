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
  let groupByOrder = (predicate, bases) => {
    switch (bases) {
    | [||] => [||]
    | _ =>
      let pin = ref(bases[0]);
      let res = ref([||]);
      let loop = (acc, x) =>
        if (predicate(x, pin^)) {
          [|x|]->Array.append(acc);
        } else {
          pin := x;
          res := (res^)->Array.append([|acc|]);
          [|x|];
        };
      let final = loop->Array.fold_left([||], bases);
      res := (res^)->Array.append([|final|]);
      res^;
    };
  };
  let bases = Js.String.split("", strand) |> groupByOrder((x, y) => x == y);
  let styled =
    (
      (index, bases) => {
        let base = bases[0];
        let style = Styles.color(colorOn, base);
        <span style key={index |> string_of_int}> {bases |> Js.Array.joinWith("") |> React.string} </span>;
      }
    )
    ->Array.mapi(bases)
    ->React.array;
  <p className="base-output"> styled </p>;
};