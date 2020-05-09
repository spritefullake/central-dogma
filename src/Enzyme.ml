(* 
a genetics system with the given nucleic bases 
for use in various genetic actions like replication
*)
module type System = sig 
  type dna = [`A | `T | `G | `C] 
  type rna = [`A | `U | `G | `C] 
  type bases = private [> rna | dna]
  type _ backbone = 
  | D: dna -> dna backbone 
  | R: rna -> rna backbone
  | None  
  val toDNA: bases -> dna backbone 
  val toRNA: bases -> rna backbone
end
(* 
  The main genetics machinery that allows life to replicate 
  and for genes to turn into mRNA
*)
module type Machinery = sig 
  include System
  val replicate: 'a backbone -> 'a backbone 
  val transcribe: dna backbone -> rna backbone 
  val reverse_transcribe: rna backbone -> dna backbone
  val to_string: 'a backbone -> string
end 
(* Meant for using generic containers containing bases with a genetic machinery *)
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end

module Standard : System = struct
  type dna = [`A | `T | `G | `C] 
  type rna = [`A | `U | `G | `C] 
  type bases = private [> rna | dna]
  type _ backbone = 
  | D: dna -> dna backbone 
  | R: rna -> rna backbone
  | None 
  let toDNA = function #dna as base -> D base | _ -> None
  let toRNA = function #rna as base -> R base | _ -> None
end
module Synthesize (S : sig 
  include System 
  val complementDNA: bases -> dna backbone 
  val complementRNA: bases -> rna backbone
  val base_to_string: [< dna | rna] -> string
end) : Machinery
= struct
  include S
  let to_string : type a . a backbone -> string = function 
  | D base -> base_to_string base 
  | R base -> base_to_string base 
  | None -> ""  
  let replicate : type a . a backbone -> a backbone = function 
  | D base -> complementDNA (base :> bases) 
  | R base -> complementRNA (base :> bases)
  | None -> None
  let transcribe = function
  | D base -> complementRNA (base :> bases)
  | None -> None
  let reverse_transcribe = function 
  | R base -> complementDNA (base :> bases) 
  | None -> None 
end
module Enzyme : Machinery = Synthesize(struct 
  include Standard
  let complementDNA = function 
  | `A -> D `T | `T -> D `A 
  | `G -> D `C | `C -> D `G 
  | `U -> D `A 
  | _ -> None
  let complementRNA = function 
  | `U -> R `A | `A -> R `U 
  | `G -> R `C | `C -> R `G 
  | `T -> R `A 
  | _ -> None
  let base_to_string = function 
  | `A -> "A" | `T -> "T" | `G -> "G" | `C -> "C" | `U -> "U"
end)
