(* 
a genetics system with the given nucleic bases 
for use in various genetic actions like replication
*)

module type System = sig
  type rna = RNA
  type dna = DNA
  type bases = .. 
  type bases += None 
  type _ backbone = 
  | D: bases -> dna backbone 
  | R: bases -> rna backbone
  val complementD: bases -> bases 
  val complementR: bases -> bases 
  val base_to_string: bases -> string
end 
module Baseline = struct
  type rna = RNA
  type dna = DNA
  type bases = .. 
  type bases += None 
  type _ backbone = 
  | D: bases -> dna backbone 
  | R: bases -> rna backbone
end 
module MakeSystem (S : System) = struct
  include S 
  let toDNA base = complementD base |> complementD 
  let toRNA base = complementR base |> complementR 
  let replicate : type a . a backbone -> a backbone = function
  | D base -> D (complementD base)
  | R base -> R (complementR base)
  let transcribe = function
  | D base -> R (complementR base)
  let reverse_transcribe = function
  | R base -> D (complementD base)
  let to_string : type a. a backbone -> string = function
  | D base -> base_to_string base 
  | R base -> base_to_string base 
end
module Standard = MakeSystem(struct
  include Baseline 
  type bases += A | T | G | C | U 
  let complementD = function 
  | A -> T | G -> C | C -> G | T -> A | U -> A | _ -> None 
  let complementR = function
  | A -> U | base -> complementD base 
  let base_to_string = function
  | A -> "A" | T -> "T" | G -> "G" | C -> "C" | U -> "U" | _ -> ""
  let from_string = function
  | "A" -> Some A | "T" -> Some T | "G" -> Some G | "U" -> Some U | _ -> None
end)
module Hachimoji = MakeSystem(struct
  include Baseline  
  type bases += S | B | P | Z
  let complementD = function 
  | S -> B | B -> S | P -> Z | Z -> P | base -> Standard.complementD base
  let complementR = complementD 
  let base_to_string = function
  | S -> "S" | B -> "B" | P -> "P" | Z -> "Z" | base -> Standard.base_to_string base
    let from_string = function
  | "S" -> Some S | "B" -> Some B | "Z" -> Some Z | "P" -> Some P | _ -> None
end)
