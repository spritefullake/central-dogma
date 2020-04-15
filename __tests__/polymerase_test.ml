open Jest
open Expect
open Polymerase

let () =
describe "Polymerase" (fun () ->

    test "Reverse transcription" (fun () -> 
        let strand = [| `A; `U; `G; `C |] in 
        expect (Array.map reverse_transcriptase strand) 
        |> toEqual [| Some `T; Some `A; Some `C; Some `G |]
    );
    test "Forward transcription" (fun () -> 
        let strand = [| `A; `T; `G; `C |] in 
        expect (Array.map rna_polymerase strand) 
        |> toEqual [| Some `U; Some `A; Some `C; Some `G |]
    );
);
