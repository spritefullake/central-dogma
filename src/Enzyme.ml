
module type System = sig 
  type dna_bases = [ `A | `T | `G | `C ] 
  type rna_bases = [ `A | `U | `G | `C ]
  val complementD: [< dna_bases | rna_bases] -> [> dna_bases]
  val complementR: [< dna_bases | rna_bases] -> [> rna_bases]
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
end
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end
module type Enzyme = sig 
  include System
  include Mappable
  type 'a strand = 'a t
  type backbone = D of dna_bases strand  | R of rna_bases strand
  val replicate: backbone -> backbone 
  val transcribe: backbone -> backbone
end 