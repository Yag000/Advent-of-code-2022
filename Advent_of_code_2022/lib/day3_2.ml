let find_first_repeated (list1, list2, list3) =
  let rec find_first_repeated' list1 list2 list3 =
    match list1 with
    | [] -> ' '
    | h :: t ->
        if List.mem h list2 && List.mem h list3 then h
        else find_first_repeated' t list2 list3
  in
  find_first_repeated' list1 list2 list3

let string_to_char_list s = List.init (String.length s) (String.get s)

let convert_to_list (s1, s2, s3) =
  let list1 = string_to_char_list s1 in
  let list2 = string_to_char_list s2 in
  let list3 = string_to_char_list s3 in
  (list1, list2, list3)

let convert_to_string list = (List.nth list 0, List.nth list 1, List.nth list 2)

let get_value c =
  if int_of_char c >= 97 && int_of_char c <= 122 then int_of_char c - 96
  else if int_of_char c >= 65 && int_of_char c <= 90 then
    int_of_char c - 64 + 26
  else 0

let compute_value list =
  convert_to_string list |> convert_to_list |> find_first_repeated |> get_value

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
  Utilities.read_file "resources/Day3/input.txt"
  |> treat_list |> Printf.printf "%d";

  print_newline ()
