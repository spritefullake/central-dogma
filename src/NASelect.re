open NucleicAcid;
[@react.component]
let make = (~value: nucleic_acid, ~onChange) => {
    
    <select id="nucleic-acid-type" 
    onChange
    value={value |> to_string}>
        <option value={DNA |> to_string}>{"DNA" |> React.string}</option>
        <option value={RNA |> to_string}>{"RNA" |> React.string}</option>
    </select>
}