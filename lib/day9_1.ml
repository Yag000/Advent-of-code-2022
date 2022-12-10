type int_pair = Pair of int * int
type direction = North | South | East | West

module IntPair = struct
  type t = int_pair

  let compare (Pair (x1, y1)) (Pair (x2, y2)) =
    if x1 = x2 && y1 = y2 then 0 else 1

  let print (Pair (x, y)) =
    print_string "(";
    print_int x;
    print_string ", ";
    print_int y;
    print_string ")"
end

module Tuple = Set.Make (IntPair)

let print_tuple (Pair (x, y)) =
  print_string "(";
  print_int x;
  print_string ", ";
  print_int y;
  print_string ")"

let direction_to_string = function
  | North -> "U"
  | South -> "D"
  | West -> "L"
  | East -> "R"

let string_to_direction = function
  | "U" -> North
  | "D" -> South
  | "L" -> West
  | "R" -> East
  | _ -> failwith "Invalid direction"

let print_movement move_ new_head new_tail =
  let direction, _ = move_ in
  print_string "Move ";
  print_string (direction_to_string direction);
  print_string " ";
  print_tuple new_head;
  print_string " ";
  print_tuple new_tail;
  print_newline ()

let get_fst (Pair (x, _)) = x
let get_scd (Pair (_, y)) = y

let distance (Pair (x1, y1)) (Pair (x2, y2)) =
  let dx = x1 - x2 in
  let dy = y1 - y2 in
  if dx = 0 then dy - 1
  else if dy = 0 then dx - 1
  else abs (dx - dy) + min dx dy

let move_up head tail =
  let new_head = Pair (get_fst head, get_scd head + 1) in
  let new_tail_x =
    if distance new_head tail = 1 then get_fst tail
    else get_fst tail + if get_fst new_head > get_fst tail then 1 else -1
  in
  let new_tail = Pair (new_tail_x, get_scd tail + 1) in
  (new_head, new_tail)

let move_down head tail =
  let new_head = Pair (get_fst head, get_scd head - 1) in
  let new_tail_x =
    if distance new_head tail = 1 then get_fst tail
    else get_fst tail + if get_fst new_head > get_fst tail then 1 else -1
  in
  let new_tail = Pair (new_tail_x, get_scd tail - 1) in
  (new_head, new_tail)

let move_left head tail =
  let new_head = Pair (get_fst head - 1, get_scd head) in
  let new_tail_y =
    if distance new_head tail = 1 then get_scd tail
    else get_scd tail + if get_scd new_head > get_scd tail then 1 else -1
  in
  let new_tail = Pair (get_fst tail - 1, new_tail_y) in
  (new_head, new_tail)

let move_right head tail =
  let new_head = Pair (get_fst head + 1, get_scd head) in
  let new_tail_y =
    if distance new_head tail = 1 then get_scd tail
    else get_scd tail + if get_scd new_head > get_scd tail then 1 else -1
  in
  let new_tail = Pair (get_fst tail + 1, new_tail_y) in
  (new_head, new_tail)

let move_one direction head tail =
  match direction with
  | North -> move_up head tail
  | South -> move_down head tail
  | West -> move_left head tail
  | East -> move_right head tail

let rec move move_ head tail set =
  let direction, num = move_ in
  if num = 0 then (head, tail, set)
  else
    let new_head, new_tail = move_one direction head tail in
    let new_set = Tuple.add new_tail set in
    print_movement move_ new_head tail;
    move (direction, num - 1) new_head new_tail new_set

let string_to_move s =
  let info = String.split_on_char ' ' s in
  match info with
  | [ direction; num ] -> (string_to_direction direction, int_of_string num)
  | _ ->
      print_string s;
      failwith "Invalid move"

let treat_input list =
  let _, _, res =
    List.fold_left
      (fun (head, tail, set) s ->
        let move_ = string_to_move s in
        let new_head, new_tail, new_set = move move_ head tail set in
        (new_head, new_tail, new_set))
      (Pair (0, 0), Pair (0, 0), Tuple.empty)
      list
  in

  res

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file_reversed "resources/day9.txt"
  |> treat_input |> Tuple.cardinal |> print_int;
  print_newline ()
