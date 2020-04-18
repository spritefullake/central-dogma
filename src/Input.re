open Bases;
[@react.component]
let make = (~strand, ~onChange, ~children) => {
  <>
    <label htmlFor="dna">
      children
    </label>
    <input
      id="dna"
      placeholder="Enter the template strand"
      value={strand_to_string(strand)}
      onChange
    />
  </>
};