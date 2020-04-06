open Bases

type nucleic_acid =
| RNA
| DNA

let to_string = function
| RNA -> "rna"
| DNA -> "dna"

let from_string = function
| "rna" -> RNA
| "dna" -> DNA
| _ -> DNA

let to_rna = function
  | Some #rna as base -> base
  | _ -> None
let to_dna = function
  | Some #dna as base -> base
  | _ -> None

let decide_parse = function
| RNA -> to_rna
| DNA -> to_dna