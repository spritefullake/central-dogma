open Chunk
open LoadCodons

let display_codons input = 
    input 
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.to_list |> String.concat "")
let make_codons input = 
    input
    |> Array.to_list
    |> chunk_list 3
let match_codon input source =
  Array.fold_left (fun acc {codon; code1; code3} -> 
    match acc with 
    | None ->
      if input = codon then Some code3 else None
    | _ -> acc
  ) None source
let match_codons input source = 
  input 
  |> make_codons 
  |> List.map (fun x -> match_codon x source)
let display_matches input =
  List.map (function 
    | Some codon -> codon
    | None -> "") input
  |> Array.of_list