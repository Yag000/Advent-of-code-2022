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
    | n -> aux ((min_int + n) :: list) (n - 1)
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
