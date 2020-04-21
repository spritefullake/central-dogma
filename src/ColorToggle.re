[@react.component]
let make = (~setToggle, ~toggle) => {
  React.useEffect0(() => {
    open Dom.Storage;
    Js.log("Using effect");
    switch (localStorage |> getItem("colorBases")) {
    | None =>
      localStorage |> setItem("colorBases", toggle |> string_of_bool);
    | Some(t) => setToggle(_ => t |> bool_of_string) |> ignore
    };
    None;
  });
  React.useEffect1(
    () => {
      Dom.Storage.(
        localStorage |> setItem("colorBases", toggle |> string_of_bool)
      );
      None;
    },
    [|toggle|],
  );
  <>
    <label htmlFor="color-toggle"> {"Color bases:" |> React.string} </label>
    <input
      id="color-toggle"
      type_="checkbox"
      checked=toggle
      onChange={_ => setToggle(oldValue => !oldValue)}
    />
  </>;
};