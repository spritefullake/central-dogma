open Jest
open Expect
open Chunk

let () =
describe "Chunking" (fun () ->

    test "Single Chunk" (fun () -> 
        let result = "This" |> chunk 1 in
        expect result |> toEqual [ "T";"h";"i";"s" ]
    );
    (*
    test "Codon Chunking" (fun () -> 
        let result = ["A";"T";"G";"C";"A";"G";"T";"T";"T"] |> make_codons in
        expect result |> toEqual [ ["A";"T";"G"]; ["C";"A";"G"]; ["T";"T";"T"] ]
    );
    *)
);
