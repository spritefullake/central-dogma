open Chunk
open LoadCodons

let display_codons input = 
    input 
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.to_list |> String.concat "")
let make_codons input = 
    input
    |> Array.to_list
    |> chunk_list 3
let match_codon input =
  Array.fold_left (fun acc {codon; aminoAcid} -> 
    match acc with 
    | None ->
      if input = codon then Some aminoAcid else None
    | _ -> acc
  ) None codonsTable
let match_codons input = 
  input 
  |> make_codons
  |> List.map match_codon
let display_matches input =
  List.map (function 
    | Some codon -> codon
    | None -> "") input
  |> Array.of_list
(* 
let filepath = "CodonsShort.txt"
let in_channel = open_in filepath
let line_stream_of_channel channel =
    Stream.from
      (fun _ -> 
        try Some (input_line channel) 
        with End_of_file -> None)
let lines = line_stream_of_channel in_channel
module CodonMap = Map.Make(String)
let standard = ref CodonMap.empty
let _ = Stream.iter 
    (fun line ->
      let columns = Js.String.split "=" line 
        |> Array.map String.trim in
      let heading = columns.(0) in
      let value = columns.(1) in 
      standard := CodonMap.add heading value !standard
    ) lines

let build_map lines = 
  let rec loop stream map =
    match Stream.peek stream with
    | Some line -> 
        let columns = Js.String.split "=" line 
            |> Array.map String.trim in 
        let heading = columns.(0) in 
        let value = columns.(1) in 
        let new_map = CodonMap.add heading value map in 
        loop stream new_map
    | None -> map in
  loop lines CodonMap.empty

let my_map = build_map lines 
let _ = Js.log my_map *)