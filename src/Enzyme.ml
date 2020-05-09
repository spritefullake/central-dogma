
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
  val replicate: 'a backbone -> 'a backbone 
  val transcribe: dna backbone -> rna backbone 
  val reverse_transcribe: rna backbone -> dna backbone
end
module Standard : System = struct
  type dna = [`A | `T | `G | `C] 
  type rna = [`A | `U | `G | `C] 
  type bases = private [> rna | dna]
  type _ backbone = 
  | D: dna -> dna backbone 
  | R: rna -> rna backbone
  | None 

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
  let toDNA = function #dna as base -> D base | _ -> None
  let toRNA = function #rna as base -> R base | _ -> None
  
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
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end