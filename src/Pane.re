[@react.component]
let make = (~title: string, ~data: string) => {
  <div className="pane">
    <h3 className="pane-title"> {title |> React.string} </h3>
    <p className="base-output"> {data |> React.string} </p>
  </div>;
};