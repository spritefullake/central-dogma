open Enzyme
module Options : Mappable with type 'a t = 'a option array = struct
  type 'a t = 'a option array 
  let map f = Array.map (function | Some x -> Some (f x) | None -> None)
end
module Machinery (S : Machinery) (M : Mappable) = struct
  include S
  let toDNA = M.map S.toDNA 
  let toRNA = M.map S.toRNA
  let replicate bases = M.map S.replicate bases
  let transcribe = M.map S.transcribe
  let reverse_transcribe = M.map S.reverse_transcribe
  let to_string bases = M.map S.to_string bases
end

module Poly = Machinery(Enzyme)(Options)

let sham : Poly.bases option array = [| Some `A; Some `C; Some `T; Some `U; None; None |]
let ram = sham |> Array.fold_left (fun acc x -> x |> function | Some x -> Array.append acc [|x|] | None -> acc) [||]
let tam = sham |> Poly.toDNA |> Poly.transcribe |> Poly.replicate |> Poly.reverse_transcribe |> Poly.transcribe