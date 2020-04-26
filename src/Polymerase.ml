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

type _ nucleic_acid =
| D : [`A | `T | `G | `C] -> [`A | `T | `G | `C] nucleic_acid
| R : [`A | `U | `G | `C] -> [`A | `U | `G | `C] nucleic_acid
| None

module type System = sig
  type t 
  val (>>=) : t nucleic_acid -> (bases -> 'a nucleic_acid) -> 'a nucleic_acid
  val complement : bases -> t nucleic_acid
end
module type Transcribes = sig 
  include System
  val replicate : t nucleic_acid -> t nucleic_acid 
  val transcribe : (module System with type t = 'a) -> t nucleic_acid -> 'a nucleic_acid
end

module MakePolymerase(M : System) : Transcribes with type t = M.t = struct
  include M 
  let replicate nucleotide = 
    nucleotide >>= complement
  let transcribe (type a) (module Into : System with type t = a) nucleotide =
    nucleotide >>= Into.complement
end

module DnaSystem = struct
  type t = [`A | `T | `G | `C]
  let complement = function
  | `A -> D `T
  | `G -> D `C
  | `T -> D `A
  | `C -> D `G
  | `U -> D `A 
  | _ -> None
  let (>>=) nucleotide f = 
    match nucleotide with
    | D base -> f (base :> bases)
    | _ -> None
end
module RnaSystem = struct
  type t = [`A | `U | `G | `C]
  let complement = function
  | `A -> R `U
  | `G -> R `C
  | `T -> R `A
  | `C -> R `G
  | `U -> R `A 
  | _ -> None
  let (>>=) nucleotide f = 
    match nucleotide with
    | R base -> f (base :> bases)
    | _ -> None
end
module DNA = MakePolymerase(DnaSystem)
module RNA = MakePolymerase(RnaSystem)
let rna = (module RNA : System with type t = RNA.t)


let e = DNA.replicate (D `A)