open Jest
open Expect
open Codons
open LoadCodons

(* Mocking the LoadCodons load *)
let loadMock = (fun () ->  
    Node.Path.normalize "Codons.tsv"
    |> Node.Fs.readFileAsUtf8Sync
    |> processRaw3Code
)
let () =

describe "Matching codons with Amino Acids" (fun () ->

    test "Start codon is AUG -> Methionine" (fun () -> 
        let table = loadMock() in
        let matched = match_codon `Three ["A";"U";"G"] table in
        expect matched |> toEqual (Some "Met")
    );
    (*
    test "UUU is Phenylalanine" (fun () -> 
        let result = ["U";"U";"U"] |> match_codon in
        expect result |> toEqual (Some "F")
    );*)
);
