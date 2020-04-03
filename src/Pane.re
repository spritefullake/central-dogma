[@react.component]
let make = (~title : string, ~data : string) => {
  <div>
    <h3> {title |> React.string} </h3>
    <p> {data |> React.string} </p>
  </div>;
};