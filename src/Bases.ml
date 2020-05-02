let to_base = function
  | "A" -> Some `A
  | "U" -> Some `U
  | "T" -> Some `T
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None
let base_to_string = function
  | `A -> Some "A"
  | `U -> Some "U"
  | `C -> Some "C"
  | `G -> Some "G"
  | `T -> Some "T"
  | _ -> None
let option_of_string = function
| Some x -> x
| _ -> ""
let bind base f =
  match base with 
  | Some b -> f b 
  | _ -> None
let (>>=) = bind
let map base f = 
  match base with
  | Some b -> Some (f b) 
  | None -> None
let parse_strand f = Array.map (fun base -> base >>= f)
let strand_to_string strand = 
  strand 
  |> Array.map (fun base -> base >>= base_to_string |> option_of_string)
  |> Array.to_list |> String.concat ""
let parse_then_string strand  f = parse_strand f strand |> strand_to_string