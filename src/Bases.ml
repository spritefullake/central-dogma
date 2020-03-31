open Belt.Option

type dna =
  | A
  | T
  | C
  | G
type rna =
  | A
  | U
  | C
  | G

let replicate_DNA (base : dna) : dna =
  match base with
  | A -> T
  | T -> A
  | C -> G
  | G -> C
let replicate_RNA (base : rna) : rna =
  match base with
  | A -> U
  | U -> A
  | C -> G
  | G -> C

let transcribe (base : dna) : rna =  
  match base with
  | A -> U
  | T -> A
  | C -> G
  | G -> C
let reverse_transcribe (base : rna) : dna =
  match base with
  | A -> T
  | U -> A
  | C -> G
  | G -> C

let to_dna (letter : string) : dna option =
  match letter with
  | "A" -> Some A
  | "T" -> Some T
  | "C" -> Some C
  | "G" -> Some G
  | _ -> None
let to_rna (letter : string) : rna option =
  match letter with
  | "A" -> Some A
  | "U" -> Some U
  | "C" -> Some C
  | "G" -> Some G
  | _ -> None

let dna_to_string (base : dna) =
  match base with
  | A -> "A"
  | T -> "T"
  | C -> "C"
  | G -> "G"
let rna_to_string (base : rna) =
  match base with
  | A -> "A"
  | U -> "U"
  | C -> "C"
  | G -> "G"
  
let parse_dna f letter = 
  letter |> to_dna |. map f
let parse_rna f letter =
  letter |> to_rna |. map f

let display_transcription letter = 
  match parse_dna transcribe letter with
  | Some base -> rna_to_string base
  | None -> ""
let display_replication letter =
  match parse_dna replicate_DNA letter with
  | Some base -> dna_to_string base
  | None -> ""