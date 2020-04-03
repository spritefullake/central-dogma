[@react.component]
let make = () => {
    <select id="nucleic-acid-type">
        <option value="dna">{"DNA" |> React.string}</option>
        <option value="rna">{"RNA" |> React.string}</option>
    </select>
}