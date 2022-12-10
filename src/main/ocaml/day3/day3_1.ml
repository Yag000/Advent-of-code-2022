open Lib

(* **
   * find_first_repeated takes two lists as arguments and returns the first element that appears in both lists.
   * *)

let find_first_repeated (list1, list2) =
  let rec find_first_repeated' list1 list2 =
    match list1 with
    | [] -> ' '
    | h :: t -> if List.mem h list2 then h else find_first_repeated' t list2
  in
  find_first_repeated' list1 list2

(* **
   * split_string_half takes a string as an argument and returns a pair of strings that represent the two halves of the
   * original string.
   * *)
let split_string_half s =
  let len = String.length s in
  let half = len / 2 in
  let s1 = String.sub s 0 half in
  let s2 = String.sub s half (len - half) in
  (s1, s2)

(* **
   * convert_to_list takes a pair of strings as an argument and returns a pair of lists of characters. The strings are
   * converted to lists of characters using the string_to_char_list function.
   * *)

let convert_to_list (s1, s2) =
  let list1 = Utilities.string_to_char_list s1 in
  let list2 = Utilities.string_to_char_list s2 in
  (list1, list2)

(* **
   * get_value takes a character as an argument and returns its value. The value is determined by the character's position
   * in the alphabet, with lowercase letters having a value between 1 and 26 and uppercase letters having a value between
   * 27 and 52. Other characters have a value of 0.
   * *)
let get_value c =
  if int_of_char c >= 97 && int_of_char c <= 122 then int_of_char c - 96
  else if int_of_char c >= 65 && int_of_char c <= 90 then
    int_of_char c - 64 + 26
  else 0

(* **
   * treat_list takes a list of strings as an argument and returns the sum of the values of the first repeated character in
   * each string. The split_string_half, convert_to_list, find_first_repeated, and get_value functions are used to compute
   * the value for each string in the list.
   * *)
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
  Utilities.read_file "resources/day3.txt" |> treat_list |> Printf.printf "%d"
