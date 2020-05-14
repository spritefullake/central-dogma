(* 
a genetics system with the given nucleic bases 
for use in various genetic actions like replication
*)
module type System = sig
  (* 
    Extensible nucleic acid bases. 
    Opaque to the outside so from_string and base_to_string
    are essential to communicating external information.
  *)
  type bases = .. 
  (* These serve as type witnesses for the backbone GADT *)
  type rna = SystemRNA
  type dna = SystemDNA
  type _ backbone = 
  | D: bases -> dna backbone 
  | R: bases -> rna backbone
  (* The base pairing function for DNA bases *)
  val complementD: bases -> bases 
  (* "..." for RNA bases *)
  val complementR: bases -> bases 
  (* 
    Crucial string marshalling functions since 
    the nucleic acid base types are abstract 
  *)
  val base_to_string: bases -> string
  val from_string: string -> bases option
end 
(* Basic genetic System blueprint from which to extend *)
module Baseline = struct
  type rna = SystemRNA
  type dna = SystemDNA
  type bases = .. 
  type bases += None 
  type _ backbone = 
  | D: bases -> dna backbone 
  | R: bases -> rna backbone
end 
(* 
  This functor creates an entire genetic system with 
  replication, transcription and reverse transcription capabilities.
  Mimics the actions of the polymerases and transcriptases. 
*)
module ExtendSystem (S : System) = struct
  include S 
  let toDNA base = D (complementD base |> complementD) 
  let toRNA base = R (complementR base |> complementR) 
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
module Standard = ExtendSystem(struct
  include Baseline 
  type bases += A | T | G | C | U 
  let complementD = function 
  | A -> T | G -> C | C -> G | T -> A | U -> A | _ -> None 
  let complementR = function
  | A -> U | base -> complementD base 
  let base_to_string = function
  | A -> "A" | T -> "T" | G -> "G" | C -> "C" | U -> "U" | _ -> ""
  let from_string = function
  | "A" -> Some A | "T" -> Some T | "G" -> Some G | "U" -> Some U | "C" -> Some C | _ -> None
end)
module Hachimoji = ExtendSystem(struct
  include Standard  
  type bases += S | B | P | Z
  let complementD = function 
  | S -> B | B -> S | P -> Z | Z -> P | base -> Standard.complementD base
  let complementR = complementD 
  let base_to_string = function
  | S -> "S" | B -> "B" | P -> "P" | Z -> "Z" | base -> Standard.base_to_string base
  let from_string = function
  | "S" -> Some S | "B" -> Some B | "Z" -> Some Z | "P" -> Some P | base -> Standard.from_string base
end)