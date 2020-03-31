let chunk size input =
  let rec loop acc input =
    match input with
    | "" -> acc
    | _ when (String.length input < size) -> input::acc
    | _ -> 
        let head = input |. (String.sub 0 size) in
        let remaining : int = (input |> String.length) - size in
        let tail = remaining |> (String.sub input size) in
        loop (head::acc) tail
  in loop [] input |> List.rev