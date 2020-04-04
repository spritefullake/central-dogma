open Belt.Option

type base = [`A | `T | `U | `G | `C ]
type rna = [`A | `U | `G | `C ]
type dna = [`A | `T | `G | `C ]


let replicate_DNA  = function
  | `A -> Some `T
  | `T -> Some `A
  | `C -> Some `G
  | `G -> Some `C
  | _ -> None
let replicate_RNA = function
  | `A -> Some `U
  | `U -> Some `A
  | `C -> Some `G
  | `G -> Some `C
  |  _ -> None
let transcribe =  function
  | `A -> Some `U
  | `T -> Some `A
  | `C -> Some `G
  | `G -> Some `C
  |  _ -> None
let reverse_transcribe = function
  | `A -> Some `T
  | `U -> Some `A
  | `C -> Some `G
  | `G -> Some `C
  | _ -> None
let to_base = function
  | "A" -> Some `A
  | "U" -> Some `U
  | "T" -> Some `T
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None
let to_string = function
  | `A -> "A"
  | `U -> "U"
  | `C -> "C"
  | `G -> "G"
  | `T -> "T"
let parse f (b : base option) =
  b |. flatMap f

let display_bases base =
  mapWithDefault base "" to_string 

let seq_to_string f seq =
  seq |> Array.map (fun x -> f x |> display_bases) |> Js.Array.joinWith ""