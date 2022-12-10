(* **
   * The cargo type is an array of lists of characters, where each list represents
   * the contents of a cargo container.
   * *)
type cargo = Array of char list

(* **
   * print_cargo takes a cargo and prints its contents, including the index of each
   * container and the characters in it in reverse order.
   * *)
let print_cargo cargo =
  for i = 0 to Array.length cargo - 1 do
    print_int i;
    print_string ": ";
    List.rev cargo.(i) |> List.iter (fun x -> print_char x);
    print_newline ()
  done

(* ** 
  * move_one takes a start position, an end position, and an array of char lists as arguments. It moves the head element
  * of the char list at the start position to the end position and updates the start position's char list to remove that
  * element. 
 * *)
let move_one start end_ cargo =
  cargo.(end_) <- Utilities.head cargo.(start) :: cargo.(end_);
  cargo.(start) <- Utilities.tail cargo.(start)

(* **
   * move takes a number of moves, a start position, an end position, and an array of char lists as arguments. It performs
   * the specified number of moves from the start position to the end position.
   * *)
let move number start end_ cargo =
  for _ = 1 to number do
    move_one start end_ cargo
  done

(* **
   * add_to_cargo takes three arguments: a position, a value, and a cargo array. It
   * adds the given value to the cargo array at the specified position.
   * *)
let add_to_cargo pos value cargo = cargo.(pos) <- value :: cargo.(pos)

(* **
   * treat_command takes a string and an array of char lists as arguments. It parses the string to extract information about
   * the number of moves, the start and end positions, and performs the specified number of moves from the start position to
   * the end position.
   * *)
let treat_command s cargo =
  let info = String.split_on_char ' ' s in
  move
    (List.nth info 1 |> int_of_string)
    ((List.nth info 3 |> int_of_string) - 1)
    ((List.nth info 5 |> int_of_string) - 1)
    cargo

(* **
   * treat_row takes a string and a number of columns as arguments. It splits the string
   * into columns and returns a list of characters representing the columns.
   * *)
let treat_row s number_of_columns =
  let rec aux acc = function
    | 0 -> acc
    | n -> aux (s.[((n - 1) * 4) + 1] :: acc) (n - 1)
  in
  aux [] number_of_columns

(* **
   * arr_row_to_cargo takes a list of characters and a cargo array as arguments. It
   * adds each character from the list to the cargo array at the corresponding position.
   * *)
let arr_row_to_cargo row cargo =
  List.iteri (fun i x -> if x = ' ' then () else add_to_cargo i x cargo) row

(* **
   * update_cargo takes a list of lists of characters and a cargo array as arguments.
   * It adds each list of characters to the cargo array at the corresponding position,
   * and then reverses each list in the cargo array.
   * *)
let update_cargo list cargo =
  List.iter (fun x -> arr_row_to_cargo x cargo) list;
  Array.iteri (fun i x -> cargo.(i) <- List.rev x) cargo

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
          update_cargo acc cargo;
          print_cargo cargo;
          aux [] xs)
        else if x.[0] = ' ' || x.[0] = '[' then
          if x.[1] != '1' then aux (acc @ [ treat_row x number_of_columns ]) xs
          else aux acc xs
        else (
          treat_command x cargo;
          aux [] xs)
  in
  aux [] list

(* **
 * get_heads_cargo takes a cargo array as an argument and returns a list of the first
 * elements of each list in the cargo array.
 * *)
let get_heads_cargo cargo =
  Array.fold_left (fun acc x -> Utilities.head x :: acc) [] cargo

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day5.txt"
  |> treat_input 9 |> get_heads_cargo |> List.rev |> List.iter print_char;
  print_newline ()
