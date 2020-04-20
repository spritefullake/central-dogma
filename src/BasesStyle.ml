module Styles = struct
  open Css

  let decideColor = function
  | "A" -> red
  | "T" | "U" -> yellow 
  | "C" -> green
  | "G" -> blue
  | _ -> white

  let toggle base = function
  | true -> decideColor base
  | false -> white

  let color base color_on = style [
      color (toggle color_on base)
  ]

end