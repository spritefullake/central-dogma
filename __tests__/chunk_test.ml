open Jest
open Expect
open Chunk

let () =
describe "Chunking" (fun () ->

    test "Single Chunk" (fun () -> 
        let result = "This" |> chunk 1 in
        expect result |> toEqual [ "T";"h";"i";"s" ]
        );
);
