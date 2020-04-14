
type sugar = Deoxyribose | Ribose
type natural_dna = [ `A | `T | `G | `C ]
type natural_rna = [ `A | `U | `G | `C ]

module type BaseSystem = sig
  type base
  val complement : base -> base option
end


module Catalyzer (M : BaseSystem) = struct
  let replicate = function
  | Some base -> M.complement base
  | _ -> None
end

let permutations pairings =
  let rec loop acc = function
  | [] -> acc
  | (first, second)::tail -> 
    let new_acc = (first, second)::(second,first)::acc in
    loop new_acc tail
  in loop [] pairings

let hachimoji_pairings = [
  `B, `S; `Z, `P
]
type nucleobase =  A | T | G | C | U 
let dna_pairings = [
  `A, `T; `G, `C;
]
let rna_pairings = [
  `U, `A; `G, `C;
]
let transcribe_pairings = [
  `U, `T; `G, `C
]
let replicate base pairings = List.assoc_opt base pairings



module type Polymerase = sig
  type base
  val pair: base -> base option
end

let make_polymerase pairings : 
  (module Polymerase) = 
  (module struct 
    type base = nucleobase
    let pair = fun base -> List.assoc_opt base pairings
  end)

let make_polymerase_fun pairings = fun base ->
  List.assoc_opt base pairings 

let dna_polymerase base = 
  make_polymerase_fun dna_pairings base
let rna_polymerase base = 
  make_polymerase_fun rna_pairings base

module NaturalDNA = struct
  type base = [ `A | `T | `G | `C ]
  let replicate = function
  | `A -> `T | `T -> `A 
  | `G -> `C | `C -> `G
  let transcribe = function
  | `A -> `U | base -> replicate base

  let complement = function
  | `A -> Some `T  | `T -> Some `A
  | `G -> Some `C  | `C -> Some `G
  (* Reverse transcription case *)
  | `U -> Some `T 
  | _ -> None
end

module NaturalRNA = struct
  type base = [ `A | `U | `G | `C ]
  let complement = function
  | `U -> Some `A
  (* Transcription case *)
  | `T -> Some `U 
  | base -> NaturalDNA.complement base
end

module HachimojiDNA = struct 
  type base = [ 
    | NaturalDNA.base 
    | `B | `S | `Z | `P 
  ]
  let complement = function
  | `S -> Some `B 
  | `B -> Some `S 
  | `Z -> Some `P 
  | `P -> Some `Z
  | base -> NaturalDNA.complement base
end

module HachimojiRNA = struct
  type base = [ NaturalRNA.base | `Z | `P | `S | `B]
  let complement = function 
  | #NaturalRNA.base as base -> NaturalRNA.complement base
  | base -> HachimojiDNA.complement base
end

type natural_bases = [ NaturalDNA.base | NaturalRNA.base ]
type hachimoji_bases = [ HachimojiDNA.base | HachimojiRNA.base ] 
type bases = [ natural_bases | hachimoji_bases ]