let hachimoji_pairings = [
  `B, `S; `Z, `P
]
let dna_pairings = [
  `A, `T; `G, `C;
]
let rna_pairings = [
  `U, `A; `G, `C;
]
let transcribe_pairings = [
  `U, `T; `G, `C
]

let make_polymerase_fun pairings = fun base ->
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
  make_polymerase_fun dna_pairings base
let rna_polymerase base = 
  make_polymerase_fun rna_pairings base
let reverse_transcriptase base =
  make_polymerase_fun transcribe_pairings base