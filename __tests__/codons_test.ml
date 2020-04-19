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
    let table = loadMock() in
    test "Start codon is AUG -> Methionine" (fun () -> 
        let matched = match_codon `Three ["A";"U";"G"] table in
        expect matched |> toEqual (Some "Met")
    );
    test "UUU is Phenylalanine for one-letter code, F" (fun () -> 
        let matched =  match_codon `One ["U";"U";"U"] table in
        expect matched |> toEqual (Some "F")
    );
);
