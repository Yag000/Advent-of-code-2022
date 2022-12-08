type cargo = Array of char list

let head = function [] -> failwith "head" | x :: _ -> x
let tail = function [] -> failwith "tail" | _ :: xs -> xs

let print_cargo cargo =
  for i = 0 to Array.length cargo - 1 do
    print_int i;
    print_string ": ";
    List.rev cargo.(i) |> List.iter (fun x -> print_char x);
    print_newline ()
  done

let get_batch number start cargo =
  let rec aux acc list = function
    | 0 -> acc
    | n -> aux (List.nth list (n - 1) :: acc) list (n - 1)
  in
  aux [] cargo.(start) number

let remove_batch number start cargo =
  let rec aux acc counter = function
    | [] -> acc
    | x :: xs ->
        if counter < number then aux acc (counter + 1) xs
        else aux (x :: acc) (counter + 1) xs
  in
  cargo.(start) <- aux [] 0 cargo.(start) |> List.rev

let move number start end_ cargo =
  let batch = get_batch number start cargo in
  remove_batch number start cargo;
  cargo.(end_) <- batch @ cargo.(end_)

let add_to_cargo pos value cargo = cargo.(pos) <- value :: cargo.(pos)

let treat_command s cargo =
  let info = String.split_on_char ' ' s in
  move
    (List.nth info 1 |> int_of_string)
    ((List.nth info 3 |> int_of_string) - 1)
    ((List.nth info 5 |> int_of_string) - 1)
    cargo

let treat_row s number_of_columns =
  let rec aux acc = function
    | 0 -> acc
    | n -> aux (s.[((n - 1) * 4) + 1] :: acc) (n - 1)
  in
  aux [] number_of_columns

let arr_row_to_cargo row cargo =
  List.iteri (fun i x -> if x = ' ' then () else add_to_cargo i x cargo) row

let update_cargo list cargo =
  List.iter (fun x -> arr_row_to_cargo x cargo) list;
  Array.iteri (fun i x -> cargo.(i) <- List.rev x) cargo

let treat_input number_of_columns list =
  let cargo = Array.make number_of_columns [] in
  let rec aux acc = function
    | [] -> cargo
    | x :: xs ->
        if x = " " || x = "" then (
          update_cargo acc cargo;
          aux [] xs)
        else if x.[0] = ' ' || x.[0] = '[' then
          if x.[1] != '1' then aux (acc @ [ treat_row x number_of_columns ]) xs
          else aux acc xs
        else (
          treat_command x cargo;
          aux [] xs)
  in
  aux [] list

let get_heads_cargo cargo =
  Array.fold_left (fun acc x -> head x :: acc) [] cargo

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/Day5/input.txt"
  |> treat_input 9 |> get_heads_cargo |> List.rev |> List.iter print_char;
  print_newline ()
