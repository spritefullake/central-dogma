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

module type System = sig 
  type dna_bases = [ `A | `T | `G | `C ] 
  type rna_bases = [ `A | `U | `G | `C ]
  val complementD: [< dna_bases | rna_bases] -> [> dna_bases]
  val complementR: [< dna_bases | rna_bases] -> [> rna_bases]
end 

module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
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

module MakeSystem (M : Mappable) (S : System) = struct 
  include S
  type 'a strand = 'a M.t
  let map = M.map
  type backbone = D of dna_bases strand | R of rna_bases strand

  let replicate = function
  | D strand -> D (map complementD strand) 
  | R strand -> R (map complementR strand) 

  let transcribe = function 
  | D strand -> R (map complementR strand)
  | R strand -> D (map complementD strand)
end

module StandardSystem = MakeSystem(struct include Array type 'a t = 'a array end)(Standard)