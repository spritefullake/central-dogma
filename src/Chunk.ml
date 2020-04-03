let chunk size input =
  let rec loop acc input =
    match input with
    | "" -> acc
    | _ when (String.length input <= size) -> input::acc
    | _ -> 
        let head = input |. (String.sub 0 size) in
        let remaining : int = (input |> String.length) - size in
        let tail = remaining |> (String.sub input size) in
        loop (head::acc) tail
  in loop [] input |> List.rev

let take size input =
  let rec loop input size =
    match input, size with
    | [],_ -> []
    | _,0 -> []
    | head::tail, count -> head::(loop tail (count - 1)) in 
  loop input size

let drop size input =
  let rec loop input size =
    match input, size with
    | [],_ -> input
    | _, 0 -> input 
    | _head::tail, count -> loop tail (count - 1) in 
  loop input size

let chunk_list size input =
  let rec loop acc = function
  | list when (List.length list <= size) -> list::acc
  | list -> 
      let elem = take size list in 
      loop (elem::acc) (drop size list)
  in loop [] input |> List.rev

let make_codons input =
  chunk_list 3 input