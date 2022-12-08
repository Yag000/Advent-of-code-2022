(*Return true if the to intervals overlap*)
let overlap (a1, b1) (a2, b2) = a1 <= b2 && a2 <= b1

let treat_string s =
  String.split_on_char ',' s
  |> List.map (fun x -> String.split_on_char '-' x |> List.map int_of_string)
  |> List.map (fun x -> (List.nth x 0, List.nth x 1))

let is_string_self_contained s =
  let l = treat_string s in
  overlap (List.nth l 0) (List.nth l 1)

let treat_list =
  let rec aux acc = function
    | [] -> acc
    | x :: xs -> aux (acc + if is_string_self_contained x then 1 else 0) xs
  in
  aux 0

let run () =
  Utilities.read_file "resources/day4_input.txt"
  |> treat_list |> Printf.printf "%d"
