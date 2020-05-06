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

module Options : Enzyme.Mappable with type 'a t = 'a option array = struct
  type 'a t = 'a option array 
  let map f = Array.map (function | Some x -> Some (f x) | None -> None)
end

module ConstructGrammar (S : Enzyme.System) (M : Enzyme.Mappable) = struct
  include S 

  let map = M.map
  type 'a wrapper = 'a M.t
  type _ action = 
  | D: dna_bases wrapper -> dna_bases action 
  | R: rna_bases wrapper -> rna_bases action
  
  let to_baseD strand = M.map (function 
  | #dna_bases as b -> Some b
  | _ -> None) strand

  let to_baseR strand = M.map (function
  | #rna_bases as b -> Some b
  | _ -> None) strand

  let replicate : type a . a action -> a action = function
  | D base -> D (map complementD base)
  | R base -> R (map complementR base)

  let transcribe = function
  | D base -> R (map complementR base)

  let reverse_transcribe = function
  | R base -> D (map complementD base)

  let interpret : type a . a action -> a action = function
  | D _ as b -> b | R _ as b -> b 

  let unwrap : type a . a action -> a wrapper = function
  | D b -> b | R b -> b 

  let to_strings : type a . a action -> string wrapper = function
  | D bases -> map to_string bases
  | R bases -> map to_string bases
end
module StandardSystem : sig 
  include Enzyme.System
  type 'a wrapper = 'a option array 
  type _ action = 
  | D: dna_bases wrapper -> dna_bases action 
  | R: rna_bases wrapper -> rna_bases action
  val transcribe: dna_bases action -> rna_bases action
  val reverse_transcribe: rna_bases action -> dna_bases action
  val replicate: 'a action -> 'a action
  val unwrap: 'a action -> 'a wrapper
  val to_baseD: [> dna_bases] wrapper -> dna_bases option wrapper 
  val to_baseR: [> rna_bases] wrapper -> rna_bases option wrapper
  val to_strings: 'a action -> string wrapper
  
end = ConstructGrammar(Enzyme.Standard)(Options)
open StandardSystem
let mat = replicate (transcribe (replicate (D [| Some `T |])))
