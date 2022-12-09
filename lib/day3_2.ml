(* **
   * find_first_repeated takes three lists as arguments and returns the first element that appears in all three lists.
   * *)

let find_first_repeated (list1, list2, list3) =
  let rec find_first_repeated' list1 list2 list3 =
    match list1 with
    | [] -> ' '
    | h :: t ->
        if List.mem h list2 && List.mem h list3 then h
        else find_first_repeated' t list2 list3
  in
  find_first_repeated' list1 list2 list3

(* **
   * convert_to_list takes three strings as arguments and returns a triplet of lists of characters. The strings are
   * converted to lists of characters using the string_to_char_list function.
   * *)
let convert_to_list (s1, s2, s3) =
  let list1 = Utilities.string_to_char_list s1 in
  let list2 = Utilities.string_to_char_list s2 in
  let list3 = Utilities.string_to_char_list s3 in
  (list1, list2, list3)

(* **
   * convert_to_string takes a list of three strings as an argument and returns a triplet of strings. The first, second, and
   * third elements of the list are returned as the first, second, and third elements of the triplet.
   * *)
let convert_to_string list = (List.nth list 0, List.nth list 1, List.nth list 2)

(* **
   * compute_value takes a list of three strings as an argument and returns the value of the first element that appears in
   * all three strings. The convert_to_string, convert_to_list, find_first_repeated, and get_value functions are used to
   * compute the value.
   * *)
let compute_value list =
  convert_to_string list |> convert_to_list |> find_first_repeated
  |> Day3_2.get_value

(* **
   * treat_list takes a list of strings as an argument and returns the sum of the values of the first repeated character in
   * groups of three strings. The compute_value function is used to compute the value for each group of three strings in the
   * list.
   * *)
let treat_list =
  let rec treat_list' total_sum acc = function
    | [] -> compute_value acc + total_sum
    | h :: t ->
        if List.length acc = 3 then
          let value = compute_value acc in
          treat_list' (value + total_sum) [ h ] t
        else treat_list' total_sum (h :: acc) t
  in
  treat_list' 0 []

let run () =
  print_newline ();
  Utilities.read_file "resources/day3_input.txt"
  |> treat_list |> Printf.printf "%d";

  print_newline ()
