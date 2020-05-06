type t =
| RNA
| DNA

let to_string = function
| RNA -> "rna"
| DNA -> "dna"

let from_string = function
| "rna" -> RNA
| "dna" -> DNA
| _ -> DNA