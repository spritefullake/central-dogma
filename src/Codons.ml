open Chunk
type effect =
  | Start
  | Stop
  | Nothing
type 'a t = {
  code1: 'a;
  code3: 'a;
  does: effect;
  codon: 'a list;}
let string_to_effect = function
| "M" -> Start
| "i" -> Start
| "*" -> Stop
| _ -> Nothing
type table = string t array

let display_codons input = 
    input 
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.to_list |> String.concat "")

let make_codons input = 
    input
    |> chunk_list 3
(* Match a codon to an amino acid on the codon table *)
let match_codon code_type input source =
  Array.fold_left (fun acc {codon; code1; code3} -> 
    match acc with 
    | None ->
      if input = codon 
      then match code_type with
      | `One -> Some code1
      | `Three | _ -> Some code3
      else None
    | _ -> acc
  ) None source

let match_codons ~letter_code ~input ~source = 
  input 
  |> make_codons 
  |> List.map (fun x -> match_codon letter_code x source)

let display_matches input =
  List.map (function 
    | Some codon -> codon
    | None -> "") input
  |> Array.of_list