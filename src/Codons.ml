open Bases
open Chunk
open Belt.Option

let make_codons (input : base option array) : string array = 
    let opt = (fun x -> mapWithDefault x "" Bases.to_string) in
    input 
    |> Array.to_list
    |> chunk_list 3
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.map opt |> Js.Array.joinWith "")