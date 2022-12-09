(* **
   * The cargo type is an array of lists of characters, where each list represents
   * the contents of a cargo container.
   * *)
type cargo = Array of char list

(* **
   * get_batch takes a number, a start position, and a cargo, and returns a list of
   * characters that represent the first `number` characters in the container at
   * position `start` in the cargo.
   * *)
let get_batch number start cargo =
  let rec aux acc list = function
    | 0 -> acc
    | n -> aux (List.nth list (n - 1) :: acc) list (n - 1)
  in
  aux [] cargo.(start) number

(* **
   * remove_batch takes three arguments: a number, a start index, and a cargo array. It
   * removes a batch of elements from the cargo array, starting at the given index and
   * containing the given number of elements. The removed elements are returned as a
   * list.
   * *)
let remove_batch number start cargo =
  let rec aux acc counter = function
    | [] -> acc
    | x :: xs ->
        if counter < number then aux acc (counter + 1) xs
        else aux (x :: acc) (counter + 1) xs
  in
  cargo.(start) <- aux [] 0 cargo.(start) |> List.rev

(* **
   * move takes four arguments: a number, a start index, an end index, and a cargo array.
   * It removes a batch of elements from the cargo array, starting at the start index
   * and containing the given number of elements. It then appends that batch to the end
   * of the cargo array, at the end index.
   * *)
let move number start end_ cargo =
  let batch = get_batch number start cargo in
  remove_batch number start cargo;
  cargo.(end_) <- batch @ cargo.(end_)

(* **
   * treat_command takes a string and a cargo array as arguments. It parses the string
   * to extract information about a command to be executed on the cargo array, and
   * then applies that command to the cargo array.
   * *)
let treat_command s cargo =
  let info = String.split_on_char ' ' s in
  move
    (List.nth info 1 |> int_of_string)
    ((List.nth info 3 |> int_of_string) - 1)
    ((List.nth info 5 |> int_of_string) - 1)
    cargo

(* **
   * treat_input takes a number of columns and a list of strings as arguments. It
   * processes each string in the list, either adding it to the cargo array, executing
   * a command on the cargo array, or updating the cargo array. It returns the final
   * state of the cargo array after all the strings have been processed.
   * *)
let treat_input number_of_columns list =
  let cargo = Array.make number_of_columns [] in
  let rec aux acc = function
    | [] -> cargo
    | x :: xs ->
        if x = " " || x = "" then (
          Day5_1.update_cargo acc cargo;
          aux [] xs)
        else if x.[0] = ' ' || x.[0] = '[' then
          if x.[1] != '1' then
            aux (acc @ [ Day5_1.treat_row x number_of_columns ]) xs
          else aux acc xs
        else (
          treat_command x cargo;
          aux [] xs)
  in
  aux [] list

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day5_input.txt"
  |> treat_input 9 |> Day5_1.get_heads_cargo |> List.rev |> List.iter print_char;
  print_newline ()
