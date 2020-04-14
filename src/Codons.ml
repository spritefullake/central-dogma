open Chunk


let make_codons (input : string array) : string array = 
    input
    |> Array.to_list
    |> chunk_list 3
    |> Array.of_list
    |> Array.map(Array.of_list)
    |> Array.map (fun x -> x |> Array.to_list |> String.concat "")