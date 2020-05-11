[@react.component]
let make = (~strand, ~onChange, ~children) => {
  <>
    <label htmlFor="dna">
      children
    </label>
    <input
      id="dna"
      placeholder="Enter the template strand"
      value={strand |> Js.Array.joinWith("")}
      onChange
    />
  </>
};