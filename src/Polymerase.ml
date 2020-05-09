module Options : Enzyme.Mappable with type 'a t = 'a option array = struct
  type 'a t = 'a option array 
  let map f = Array.map (function | Some x -> Some (f x) | None -> None)
end
open Enzyme
module Machinery (S : System) (M : Mappable) = struct
  type dna = S.dna
  type rna = S.rna
  type bases = S.bases
  type 'a t = 'a M.t
  type 'a backbone = 'a S.backbone
  let toDNA = M.map S.toDNA 
  let toRNA = M.map S.toRNA
  let replicate bases = M.map S.replicate bases
  let transcribe = M.map S.transcribe
  let reverse_transcribe = M.map S.reverse_transcribe
end