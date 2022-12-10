(* **
   * get_min takes a list of integers as an argument and returns the minimum value in the list.
   * *)
let get_min list =
  let rec aux lastMax = function
    | [] -> lastMax
    | value :: l -> if value < lastMax then aux value l else aux lastMax l
  in
  aux max_int list

(* **
   * replace takes a new value and a list of integers as arguments and returns a new list of
   * integers with the minimum value in the input list replaced by the new value. If the new
   * value is less than the minimum value, the input list is returned unchanged.
   * *)
let replace new_value list =
  let min_value = get_min list in
  let rec aux new_list = function
    | [] -> new_list
    | value :: l ->
        if value = min_value then aux (new_value :: new_list) l
        else aux (value :: new_list) l
  in
  if min_value < new_value then aux [] list else list

(* **
   * init_list takes an integer n as an argument and returns a list of n integers, where each
   * integer is initialized to min_int - n. This is used to initialize a list of maximum values
   * to be updated with the top n maximum values from an input list.
   * *)
let init_list n =
  let rec aux list = function
    | 0 -> list
    | n -> aux ((min_int - n) :: list) (n - 1)
  in
  aux [] n

(* **
   * get_top_max takes an integer n and a list of integers as arguments and returns the
   * top n maximum values from the input list. The replace function is used to update a
   * list of maximum values with the next maximum value from the input list.
   * *)
let get_top_max n list =
  let rec aux temporal_max = function
    | [] -> temporal_max
    | value :: l -> aux (replace value temporal_max) l
  in
  aux (init_list n) list

(* **
    * print_int_list takes a list of integers as an argument and prints each value
   * in the list on a separate line.
   * *)
let print_int_list list =
  List.iter
    (fun value ->
      print_int value;
      print_newline ())
    list

let run () =
  Utilities.read_file "resources/day1_input.txt"
  |> Day1_1.get_calories_list |> get_top_max 3 |> print_int_list
