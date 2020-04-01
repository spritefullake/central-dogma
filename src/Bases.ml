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

let to_dna = function
  | "A" -> Some `A
  | "T" -> Some `T
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None
let to_rna = function
  | "A" -> Some `A
  | "U" -> Some `U
  | "C" -> Some `C
  | "G" -> Some `G
  | _ -> None

let to_string = function
  | `A -> "A"
  | `U -> "U"
  | `C -> "C"
  | `G -> "G"
  | `T -> "T"
  
let parse_dna f letter = 
  letter |> to_dna |. map f
let parse_rna f letter =
  letter |> to_rna |. map f

let display_transcription letter = 
  match parse_dna transcribe letter with
  | Some base -> to_string base
  | None -> ""
let display_replication letter =
  match parse_dna replicate_DNA letter with
  | Some base -> to_string base
  | None -> ""