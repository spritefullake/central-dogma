open Jest
open Expect
open Bases

let willBe x y = expect x |> toBe y
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