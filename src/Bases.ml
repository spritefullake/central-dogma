let to_base = function
  | "A" -> Some `A
  | "U" -> Some `U
  | "T" -> Some `T
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None
let base_to_string = function
  | `A -> "A"
  | `U -> "U"
  | `C -> "C"
  | `G -> "G"
  | `T -> "T"
  | _ -> ""
let option_to_string = function
| Some x -> x 
| None -> ""
let bind base f =
  match base with 
  | Some b -> f b 
  | _ -> None
let (>>=) = bind
let strand_to_string strand = 
  strand 
  |> Array.map (fun base -> base >>= (fun x -> Some (x |> base_to_string)) |> option_to_string)
  |> Array.to_list |> String.concat ""