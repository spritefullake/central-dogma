[@react.component]
let make = (~title: string, ~data: string, ~colorOn: bool) => {
  <div className="pane">
    <h3 className="pane-title"> {title |> React.string} </h3>
    <StyledBases strand=data colorOn/>
  </div>;
};