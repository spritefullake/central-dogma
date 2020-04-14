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

open Polymerase
let choose base = function
| DNA -> List.fold_left (walk_assoc base) None dna_pairings
| RNA -> List.fold_left (walk_assoc base) None rna_pairings