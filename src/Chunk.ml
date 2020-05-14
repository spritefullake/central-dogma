let chunk size input =
  let rec loop acc input =
    match input with
    | "" -> acc
    | _ when (String.length input <= size) -> input::acc
    | _ -> 
        let head = (String.sub input 0 size) in
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

let chunk_array size input =
  let length = Array.length input in
  let bins = length / size + (length mod size) in
  let result = Array.make_matrix (Array.length input / size) size input.(0) in
  for i = 0 to bins do
    if i + size <= Array.length input then
      result.(i) <- (Array.sub input i size)
    else
      result.(i) <- (Array.sub input i (Array.length input))
  done;
  result