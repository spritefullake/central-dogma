open Enzyme
(* Any structure that can be mapped over like Option or Array*)
module type Mappable = sig 
  type 'a t 
  val map: ('a -> 'b) -> 'a t -> 'b t
end
(* 
  Allows defining a mappable container across 
  which to apply the functions for brevity. 
  ### Note that the from_string function is 
  excluded from being generically mapped; 
  this is to avoid nested options like Some (Some _)
  and semantically from_string only makes sense with a string input.
*)
module MakeMappedSystem (S : System) (M : Mappable) = struct
  include ExtendSystem(S) 
  include M 
  let toDNA bases = map toDNA bases
  let toRNA bases = map toRNA bases  
  let replicate bases = map replicate bases
  let transcribe bases = map transcribe bases 
  let reverse_transcribe bases = map reverse_transcribe bases 
  let to_string bases = map to_string bases
end
module OptionMap : Mappable with type 'a t = 'a option = struct
  type 'a t = 'a option
  let map f = function Some x -> Some (f x) | None -> None
end
module ArrayOptions : Mappable with type 'a t = 'a OptionMap.t array = struct
  type 'a t = 'a OptionMap.t array 
  let map f = Array.map (OptionMap.map f) 
end
module Poly = MakeMappedSystem(Standard)(ArrayOptions)