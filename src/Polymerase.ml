let hachimoji_pairings = [
  `B, `S; `Z, `P
]
let dna_pairings = [
  `A, `T; `G, `C;
]
let rna_pairings = [
  `U, `A; `G, `C;
]
(* 
  Order of pairings matter. Earlier pairings 
  get higher priority compared to later 
  pairings due to none_until_some
*)
let transcribe_pairings = [
  `U, `A; `A, `T;  `G, `C 
]


let walk_assoc base = (fun acc (first, second) ->
  match acc with | Some _ as b -> b
  | None -> 
    if base == first then Some first 
    else if base == second then Some second
    else None
  )

let make_polymerase pairings = fun base ->
  let none_until_some = (fun acc (first, second) ->
    match acc with | Some _ as b -> b
    | None ->  
      if base == first then
        Some second
      else if base == second then
        Some first 
      else 
        None
    ) 
  in List.fold_left none_until_some None pairings

let dna_polymerase base = 
  make_polymerase dna_pairings base

let rna_polymerase base = 
  make_polymerase transcribe_pairings base
  
let reverse_transcriptase base =
  (* Reverse inverts the priority so A -> T instead of A -> U*)
  make_polymerase (List.rev transcribe_pairings) base

type bases = [ `A | `T | `G | `C | `U ]
type dna_bases = [ `A | `T | `G | `C ]
type rna_bases = [ `A | `U | `G | `C ]

type 'a strand = 'a array
type _ ghost = 
| D: dna_bases strand -> _ ghost 
| R: rna_bases strand -> _ ghost 

let complementD = function 
| `A -> `T | `T -> `A 
| `G -> `C | `C -> `G 
| `U -> `A 
let complementR = function 
| `A -> `U | `U -> `A 
| `G -> `C | `C -> `G 
| `T -> `A 

let replicate = function
| D strand -> D (Array.map complementD strand) 
| R strand -> R (Array.map complementR strand) 

let transcribe = function 
| D strand -> R (Array.map complementR strand)
| R strand -> D (Array.map complementD strand)
