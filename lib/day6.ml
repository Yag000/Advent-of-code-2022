module Chars = Set.Make (Char)

let head = function [] -> failwith "head" | x :: _ -> x
let string_to_char_list s = List.init (String.length s) (String.get s)

let are_all_chars_different (s : string) : bool =
  let chars = string_to_char_list s |> Chars.of_list in
  String.length s = Chars.cardinal chars

let treat_string number s =
  let rec aux i sub_string =
    if i = String.length s then -1
    else if are_all_chars_different (sub_string ^ String.make 1 s.[i]) then
      i + 1
    else aux (i + 1) (String.sub sub_string 1 (number - 2) ^ String.make 1 s.[i])
  in

  aux (number - 1) (String.sub s 0 (number - 1))

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day6_input.txt"
  |> head |> treat_string 14 |> print_int;
  print_newline ()
