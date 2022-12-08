let is_contained (x0, x1) (y0, y1) =
  if x0 >= y0 && x1 <= y1 then true
  else if y0 >= x0 && y1 <= x1 then true
  else false

let treat_string s =
  String.split_on_char ',' s
  |> List.map (fun x -> String.split_on_char '-' x |> List.map int_of_string)
  |> List.map (fun x -> (List.nth x 0, List.nth x 1))

let is_string_self_contained s =
  let l = treat_string s in
  is_contained (List.nth l 0) (List.nth l 1)

let treat_list =
  let rec aux acc = function
    | [] -> acc
    | x :: xs -> aux (acc + if is_string_self_contained x then 1 else 0) xs
  in
  aux 0

let run () =
  Utilities.read_file "resources/day4_input.txt"
  |> treat_list |> Printf.printf "%d"
