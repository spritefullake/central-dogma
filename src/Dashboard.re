open Bases;
open NucleicAcid;
[@react.component]
let make = () => {
  let (baseType, setBaseType) = React.useState(() => DNA);
  let updateBaseType = e => {
    let value = e->ReactEvent.Form.target##value->from_string;
    setBaseType(_ => value);
  };
  let (strand, setStrand) = React.useState(() => [||]);
  let updateStrand = e => {
    let filterBaseType = x => choose(x, baseType);
    //Ensure only valid base inputs are accepted
    let value =
      e->ReactEvent.Form.target##value
      |> Js.String.toUpperCase
      |> Js.String.split("")
      |> Array.map(letter => letter |> to_base >>= filterBaseType);
    setStrand(_ => value);
  };
  let (colorBases, setColorBases) = React.useState(() => true);
  <>
    <Input strand onChange=updateStrand>
      {"Enter the " |> React.string}
      <NASelect value=baseType onChange=updateBaseType />
      {" template strand" |> React.string}
      <br/>
      <ColorToggle toggle=colorBases setToggle=setColorBases />
    </Input>
    <Output strand baseType colorBases />
  </>;
};