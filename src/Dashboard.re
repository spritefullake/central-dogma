open Bases;
open NucleicAcid;
[@react.component]
let make = () => {
  let (baseType, setBaseType) = React.useState(() => DNA);
  let updateBaseType = e => {
    
    let value = e->ReactEvent.Form.target##value;
    let newBaseType = value->from_string;
    setBaseType(_ => newBaseType);
  };
  let (strand, setStrand) = React.useState(() => [||]);
  let updateStrand = e => {
    //Ensure only valid base inputs are accepted
    let value =
      e->ReactEvent.Form.target##value
      |> Js.String.toUpperCase
      |> Js.String.split("");
    let bases = Array.map(to_base,value);
    setStrand(_ => bases);
    
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