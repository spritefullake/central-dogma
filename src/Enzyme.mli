module type System = sig 
  type dna_bases = [ `A | `T | `G | `C ] 
  type rna_bases = [ `A | `U | `G | `C ]
  val complementD: [< dna_bases | rna_bases] -> [> dna_bases]
  val complementR: [< dna_bases | rna_bases] -> [> rna_bases]
  val to_string: [< dna_bases | rna_bases] -> string
end 
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end
module Standard : System