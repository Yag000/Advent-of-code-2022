(* **
   * overlap takes two pairs of integers as arguments and returns whether the two pairs overlap. This is determined by
   * checking whether the first pair's first integer is less than or equal to the second pair's second integer, and whether
   * the second pair's first integer is less than or equal to the first pair's second integer.
   * *)
let overlap (a1, b1) (a2, b2) = a1 <= b2 && a2 <= b1

(* **
   * does_string_overlap takes a string as an argument and returns whether the string represents a pair of integers that
   * overlaps with another pair of integers. The string is treated using the Day4_1.treat_string function and then checked
   * for overlap using the overlap function.
   * *)
let does_string_overlap s =
  let l = Day4_1.treat_string s in
  overlap (List.nth l 0) (List.nth l 1)

(* **
 * treat_list takes a list of strings as an argument and returns the number of strings that represent overlapping pairs of
 * integers. The does_string_overlap function is used to check each string in the list for overlap.
 * *)
let treat_list =
  let rec aux acc = function
    | [] -> acc
    | x :: xs -> aux (acc + if does_string_overlap x then 1 else 0) xs
  in
  aux 0

let run () =
  Utilities.read_file "resources/day4.txt" |> treat_list |> Printf.printf "%d"
