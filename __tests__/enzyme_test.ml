open Jest
open Expect
open Enzyme

let () =
describe "Enzyme" (fun () ->

    test "Test stub" (fun () -> 
        expect true |> toEqual true
    );
);
