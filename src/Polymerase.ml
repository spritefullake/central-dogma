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
  
  let incorporateD bases : 'a strand = map glycosylateD bases
  let incorporateR bases : 'a strand = map glycosylateR bases
  let ligateD bases : 'a strand = map (flat_map glycosylateD) bases
  let ligateR bases : 'a strand = map (flat_map glycosylateR) bases
  
  let replicate = map (flat_map (lift replicate'))
  let transcribe = map (flat_map (lift transcribe'))
end
module Container : Mappable with type 'a t = 'a array = struct 
  type 'a t = 'a array 
  let map = Array.map
end
module StandardSystem = ExtendSystem(Container)(Standard)

module Options : Mappable with type 'a t = 'a option array = struct
  type 'a t = 'a option array 
  let map_option f = function
  | Some x -> Some (f x)
  | None -> None
  let map f = Array.map (map_option f)
end
module ConstructGrammar (S : System) (M : Mappable) = struct
  include S 

  let map = M.map
  type 'a wrapper = 'a M.t
  type _ action = 
  | D: dna_bases wrapper -> dna_bases action 
  | R: rna_bases wrapper -> rna_bases action
  | Transcribe: dna_bases action -> rna_bases action 
  | ReverseTranscribe: rna_bases action -> dna_bases action
  | Replicate: 'a action -> 'a action

  let replicate : type a . a action -> a action = function
  | D base -> D (map complementD base)
  | R base -> R (map complementR base)
  | _ as a -> a

  let transcribe = function
  | D base -> R (map complementR base)
  | action -> Transcribe action

  let reverse_transcribe = function
  | R base -> D (map complementD base)
  | action -> ReverseTranscribe action

  let rec interpret : type a . a action -> a action = function
  | D _ as b -> b | R _ as b -> b 
  | Transcribe action -> transcribe (interpret action)
  | Replicate action -> replicate (interpret action)
  | ReverseTranscribe action -> reverse_transcribe (interpret action)

end