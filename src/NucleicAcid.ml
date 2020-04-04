open Bases

type nucleic_acid =
| RNA
| DNA

let filter = function
| RNA -> to_rna
| DNA -> to_dna

let to_string = function
| RNA -> "rna"
| DNA -> "dna"

let from_string = function
| "rna" -> RNA
| "dna" -> DNA
| _ -> DNA