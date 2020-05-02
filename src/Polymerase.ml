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

open Enzyme
(* Monads are building blocks, functors act top down 
compare filtering (functor) to monadic operations
*)
module ExtendSystem (M : Mappable) (S : System) = struct
  include S 
  include M
  
  type backbone = D of dna_bases | R of rna_bases
  type 'a strand = 'a option t

  let replicate' = function
  | D base -> D (complementD base)
  | R base -> R (complementR base)
  let transcribe' = function
  | D base -> R (complementR base)
  | R base -> D (complementD base)
  let glycosylateD = function
  | #dna_bases as b -> Some (D b)
  | _ -> None
  let glycosylateR = function 
  | #rna_bases as b -> Some (R b) 
  | _ -> None
  
  let lift f x = Some (f x) 
  let (>>=) x f = match x with Some x -> f x | _ -> None
  let flat_map f x = x >>= f

  let ligateD bases = map (flat_map glycosylateD) bases
  let ligateR bases = map (flat_map glycosylateR) bases
  
  let replicate = map (flat_map (lift replicate'))
  let transcribe = map (flat_map (lift transcribe'))
end
module MakeSystem (M : Mappable) (S : System) = struct 
  include S
  type 'a t = 'a M.t
  type 'a strand = 'a t
  let map = M.map
  type backbone = D of dna_bases strand | R of rna_bases strand

  let replicate = function
  | D strand -> D (map complementD strand) 
  | R strand -> R (map complementR strand) 

  let transcribe = function 
  | D strand -> R (map complementR strand)
  | R strand -> D (map complementD strand)

  let toDStrand strand = 
    filter (function | #dna_bases -> true | _ -> false) strand
  let toRStrand strand = 
    filter (function | #rna_bases -> true | _ -> false) strand
  (* Monadic strand conversion functions *)
  let tryDStrand strand =
    map (function | #dna_bases as b -> Some b | _ -> None) strand
  let tryRStrand strand =
    map (function | #rna_bases as b -> Some b | _ -> None) strand
end

module Container : Mappable = struct 
  include Array type 'a t = 'a array 
  let filter chooser = 
    fold_left (fun acc x -> if chooser x then (append [|x|] acc) else acc) [||]
end
module StandardSystem = MakeSystem(Container)(Standard)