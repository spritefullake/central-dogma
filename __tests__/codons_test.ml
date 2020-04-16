open Jest
open Expect
open Codons

let () = ()
(*
describe "Matching codons with Amino Acids" (fun () ->

    test "Start codon is AUG -> Methionine" (fun () -> 
        let result = ["A";"U";"G"] |> match_codon in
        expect result |> toEqual (Some "M")
    );
    test "UUU is Phenylalanine" (fun () -> 
        let result = ["U";"U";"U"] |> match_codon in
        expect result |> toEqual (Some "F")
    );
);
*)