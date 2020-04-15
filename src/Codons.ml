open Chunk
open LoadCodons

let make_codons (input : string array) : string array = 
    input
    |> Array.to_list
    |> chunk_list 3
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.to_list |> String.concat "")

let match_codons input =
  Array.map (fun {codon} -> 
    if input = codon then Some codon else None
  ) codonsTable

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