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
    test "Group bases in order" (fun () -> 
      let are_equal = fun x y -> x = y in 
      let result = [ "A"; "A"; "C"; "C"; "C"; "A";"A";"T";"C"] |> group_by_order are_equal in 
      expect result |> toEqual [ ["A";"A"]; ["C";"C";"C"]; ["A";"A"]; ["T"]; ["C"] ]
    );
    test "Group bases in reverse order" (fun () ->
      let are_equal = fun x y -> x = y in 
      let result = [ "A"; "A"; "C"; "C"; "C"; "A";"A";"T";"C"] |> group_by_order ~reverse:true are_equal in 
      expect result |> toEqual [["C"]; ["T"]; ["A"; "A"]; ["C"; "C"; "C"]; ["A"; "A"]]
    );
);
