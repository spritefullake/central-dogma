
module type System = sig 
  type dna_bases = [ `A | `T | `G | `C ] 
  type rna_bases = [ `A | `U | `G | `C ]
  val complementD: [< dna_bases | rna_bases] -> [> dna_bases]
  val complementR: [< dna_bases | rna_bases] -> [> rna_bases]
  val to_string: [< dna_bases | rna_bases] -> string
end
module Standard : System = struct
  type dna_bases = [`A | `T | `G | `C] 
  type rna_bases = [`A | `U | `G | `C]
  let complementD = function 
  | `A -> `T | `T -> `A 
  | `G -> `C | `C -> `G 
  | `U -> `A 
  let complementR = function 
  | `A -> `U | `U -> `A 
  | `G -> `C | `C -> `G 
  | `T -> `A 
  let to_string = function 
  | `A -> "A" | `T -> "T" | `U -> "U" 
  | `G -> "G" | `C -> "C"
end
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end