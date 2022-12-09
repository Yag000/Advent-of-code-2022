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

let string_to_char_list s = s |> String.to_seq |> List.of_seq
let head = function [] -> failwith "head" | x :: _ -> x
let tail = function [] -> failwith "tail" | _ :: xs -> xs
