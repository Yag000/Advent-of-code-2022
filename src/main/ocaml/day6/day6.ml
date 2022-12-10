open Lib

(* Defines a module named [Chars] that uses the [Set.Make]
   functor to create a set data structure of type [char]. *)
module Chars = Set.Make (Char)

(* **
   * [are_all_chars_different s] is [true]
   * if all characters in [s] are unique, or [false] otherwise.
   * *)
let are_all_chars_different (s : string) : bool =
  (* Convert [s] to a list of characters
     and create a set of characters from the list. *)
  let chars = Utilities.string_to_char_list s |> Chars.of_list in
  String.length s = Chars.cardinal chars

(* **
   * [treat_string number s] is the index of the last
   * character in [s] that can be added to a substring of length
   * [number] without repeating any characters.
   * *)
let treat_string number s =
  let rec aux i sub_string =
    if i = String.length s then -1
    else if are_all_chars_different (sub_string ^ String.make 1 s.[i]) then
      i + 1
    else aux (i + 1) (String.sub sub_string 1 (number - 2) ^ String.make 1 s.[i])
  in

  aux (number - 1) (String.sub s 0 (number - 1))

let run1 () =
  Utilities.read_file "resources/day6.txt"
  |> Utilities.head |> treat_string 4 |> print_int

let run2 () =
  Utilities.read_file "resources/day6.txt"
  |> Utilities.head |> treat_string 14 |> print_int

let () =
  print_newline ();
  print_endline "Day 4";
  print_newline ();
  print_endline "Part 1";
  print_newline ();
  run1 ();
  print_newline ();
  print_newline ();
  print_endline "Part 2";
  print_newline ();
  run2 ();
  print_newline ()
