open Belt.Option

type base = [`A | `T | `U | `G | `C ]
type rna = [`A | `U | `G | `C ]
type dna = [`A | `T | `G | `C ]


let replicate_DNA  = function
  | `A -> `T
  | `T -> `A
  | `C -> `G
  | `G -> `C
let replicate_RNA = function
  | `A -> `U
  | `U -> `A
  | `C -> `G
  | `G -> `C
let transcribe =  function
  | `A -> `U
  | `T -> `A
  | `C -> `G
  | `G -> `C
let reverse_transcribe = function
  | `A -> `T
  | `U -> `A
  | `C -> `G
  | `G -> `C
let to_base = function
  | "A" -> Some `A
  | "U" -> Some `U
  | "T" -> Some `T
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None
let to_dna = function
  | Some #dna as x -> x
  | _ -> None
let to_rna = function
  | Some #rna as x -> x 
  | _ -> None
let to_string = function
  | `A -> "A"
  | `U -> "U"
  | `C -> "C"
  | `G -> "G"
  | `T -> "T"
  
let parse_dna f base = 
  base |> to_dna |. map f
let parse_rna f base =
  base |> to_rna |. map f

let parse_str_dna f letter = 
  letter |> to_base |> to_dna |. map f
let parse_str_rna f letter =
  letter |> to_base |> to_rna |. map f

let display_bases base =
  mapWithDefault base "" to_string 

let display_transcription letter = 
  mapWithDefault (parse_str_dna transcribe letter) "" to_string  

let display_reverse_transcription letter =
  mapWithDefault (parse_str_rna reverse_transcribe letter) "" to_string  

let display_replication letter =
  mapWithDefault (parse_str_dna replicate_DNA letter) "" to_string

let seq_to_string f seq =
  seq |> Array.map (fun x -> f x |> display_bases) |> Js.Array.joinWith ""