let find_first_repeated (list1, list2) =
  let rec find_first_repeated' list1 list2 =
    match list1 with
    | [] -> ' '
    | h :: t -> if List.mem h list2 then h else find_first_repeated' t list2
  in
  find_first_repeated' list1 list2

let split_string_half s =
  let len = String.length s in
  let half = len / 2 in
  let s1 = String.sub s 0 half in
  let s2 = String.sub s half (len - half) in
  (s1, s2)

let string_to_char_list s = List.init (String.length s) (String.get s)

let convert_to_list (s1, s2) =
  let list1 = string_to_char_list s1 in
  let list2 = string_to_char_list s2 in
  (list1, list2)

let get_value c =
  if int_of_char c >= 97 && int_of_char c <= 122 then int_of_char c - 96
  else if int_of_char c >= 65 && int_of_char c <= 90 then
    int_of_char c - 64 + 26
  else 0

let treat_list =
  let rec treat_list' acc = function
    | [] -> acc
    | h :: t ->
        let value =
          split_string_half h |> convert_to_list |> find_first_repeated
          |> get_value
        in
        treat_list' (acc + value) t
  in
  treat_list' 0

let run () =
  Utilities.read_file "resources/day3_input.txt"
  |> treat_list |> Printf.printf "%d"
