[@react.component]
let make = (~strand, ~onChange, ~children) => {
  <>
    <label htmlFor="dna">
      children
    </label>
    <textarea
      id="dna"
      placeholder="Enter the template strand"
      value={strand |> Js.Array.joinWith("")}
      onChange
    />
  </>
};