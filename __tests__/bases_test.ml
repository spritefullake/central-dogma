open Jest
open Expect
open Bases
open Belt.Option
let willBe x y = expect x |> toBe y
let map_opts f = Array.map (fun i -> Belt.Option.map i f)
let () =   
describe "Replication" (fun () -> 
    testAll "Correctly replicates single bases of DNA" 
        ["A","T"; 
        "T","A"; 
        "C","G"; 
        "G","C"] 
    (fun (input, correct) ->
        display_replication input |> willBe correct
    );
);

describe "Transcription" (fun () ->
    testAll "Correctly transcribes DNA to RNA" 
        ["A","U"; 
        "T","A"; 
        "C","G"; 
        "G","C"] 
    (fun (input, correct) ->
        display_transcription input |> willBe correct
    );

    testAll "Erroneous string parsing"
        ["!"; "W"; "هذا غير صحيح"]
    (fun input -> 
        display_transcription input |> willBe "";
    );

    test "DNA base sequences" (fun () ->
        let bases = "ATGC" |. Js.String.split "" in
        let correct = "TACG" |. Js.String.split "" in
        Array.map display_transcription bases |> expect |> toEqual correct
    );
);
describe "DNA and RNA interactions" (fun () -> 
    test "reverse transcription reverses transcription" (fun () -> 
        let input = "ATGCGGTAA" |> Js.String.split "" in
        input 
        |> Array.map to_base
        |> Array.map to_dna
        |> map_opts transcribe
        |> map_opts reverse_transcribe
        |> Array.map (function 
            | None -> ""
            | Some x -> to_string x
        )
        |> expect |> toEqual input
    );

);