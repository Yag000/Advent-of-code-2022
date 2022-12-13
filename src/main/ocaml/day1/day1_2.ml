open Lib

(**
     print_int_list takes a list of integers as an argument and prints each value
     in the list on a separate line.
*)
let print_int_list list =
  List.iter
    (fun value ->
      print_int value;
      print_newline ())
    list

let run () =
  Utilities.read_file "resources/day1.txt"
  |> Day1_1.get_calories_list |> Utilities.get_top_max 3
  |> List.fold_left ( + ) 0 |> print_int
