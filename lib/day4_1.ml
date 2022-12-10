(* **
   * is_contained takes two pairs of integers as arguments and returns a boolean indicating whether the first pair is
   * contained within the second pair.
   * *)
let is_contained (x0, x1) (y0, y1) =
  if x0 >= y0 && x1 <= y1 then true
  else if y0 >= x0 && y1 <= x1 then true
  else false

(* **
   * treat_string takes a string as an argument and returns a list of pairs of integers. The string is split on the ','
   * character and then each substring is split on the '-' character. The resulting substrings are parsed as integers and
   * returned as pairs.
         * *)
let treat_string s =
  String.split_on_char ',' s
  |> List.map (fun x -> String.split_on_char '-' x |> List.map int_of_string)
  |> List.map (fun x -> (List.nth x 0, List.nth x 1))

(* **
   * is_string_self_contained takes a string as an argument and returns whether the string represents a pair of integers that
   * is self-contained within another pair of integers. The string is treated using the treat_string function and then
   * checked for self-containment using the is_contained function.
   * *)
let is_string_self_contained s =
  let l = treat_string s in
  is_contained (List.nth l 0) (List.nth l 1)

(* **
   * treat_list takes a list of strings as an argument and returns the number of strings that represent self-contained
   * pairs of integers. The is_string_self_contained function is used to check each string in the list for self-containment.
   * *)
let treat_list =
  let rec aux acc = function
    | [] -> acc
    | x :: xs -> aux (acc + if is_string_self_contained x then 1 else 0) xs
  in
  aux 0

let run () =
  Utilities.read_file "resources/day4_input.txt"
  |> treat_list |> Printf.printf "%d"
