(* **
   * read_file takes a filename and reads the contents of the file line by line,
   * returning a list of strings, where each string represents a line from the file.
   * *)
let read_file filename =
  let lines = ref [] in
  let channel = open_in filename in
  try
    while true do
      lines := input_line channel :: !lines
    done;
    !lines
  with End_of_file ->
    close_in channel;
    List.rev !lines

(* **
   * read_file_reversed takes a filename and reads the contents of the file line by line,
   * returning a list of strings, where each string represents a line from the file
   * in reverse order.
   * *)
let read_file_reversed filename =
  let lines = ref [] in
  let channel = open_in filename in
  try
    while true do
      lines := input_line channel :: !lines
    done;
    !lines
  with End_of_file ->
    close_in channel;
    !lines

(* **
   * string_to_char_list takes a string and returns a list of characters for that string.
   * *)
let string_to_char_list s = s |> String.to_seq |> List.of_seq

(* **
   * head takes a list and returns the first element of the list.
   * If the list is empty, it raises the "head" exception.
   * *)
let head = function [] -> failwith "head" | x :: _ -> x

(* **
   * tail takes a list and returns a new list that contains all the elements of the
   * original list except the first one.
   * If the list is empty, it raises the "tail" exception.
   * *)
let tail = function [] -> failwith "tail" | _ :: xs -> xs
