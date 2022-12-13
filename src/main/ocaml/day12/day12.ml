open Lib

module IntPair = struct
  type t = int * int

  let compare (x1, y1) (x2, y2) = compare (x1, y1) (x2, y2)
end

module Tuples = Set.Make (IntPair)

let is_movement_possible map x y next_x next_y visited =
  if
    next_x < 0
    || next_x >= Array.length map
    || next_y < 0
    || next_y >= Array.length map.(0)
  then false
  else
    let pos1 = if map.(x).(y) = 'S' then 'a' else map.(x).(y) in
    let pos2 =
      if map.(next_x).(next_y) = 'E' then 'z' else map.(next_x).(next_y)
    in
    int_of_char pos2 - int_of_char pos1 <= 1
    && not (Tuples.mem (next_x, next_y) visited)

let all_possible map x y visited =
  if x < 0 || x >= Array.length map || y < 0 || y >= Array.length map.(0) then
    []
  else
    let rec aux acc = function
      | [] -> acc
      | (next_x, next_y) :: t ->
          if is_movement_possible map x y next_x next_y visited then
            aux ((next_x, next_y) :: acc) t
          else aux acc t
    in
    aux [] [ (x + 1, y); (x - 1, y); (x, y + 1); (x, y - 1) ]

let search_path starting_values array =
  let queue = ref [] in
  let visited = ref Tuples.empty in
  Array.iteri
    (fun i row ->
      Array.iteri
        (fun j c ->
          if List.mem c starting_values then (
            queue := (0, i, j) :: !queue;
            visited := Tuples.add (i, j) !visited))
        row)
    array;
  let rec aux = function
    | [] -> -1
    | (times, x, y) :: t ->
        if array.(x).(y) = 'E' then times
        else
          let next_movements = all_possible array x y !visited in
          let next_movements =
            List.map (fun (x, y) -> (times + 1, x, y)) next_movements
          in
          List.iter
            (fun (_, i, j) -> visited := Tuples.add (i, j) !visited)
            next_movements;
          aux (t @ next_movements)
  in

  aux !queue


let () =
  let t1 = Sys.time () in
  let input =
    Utilities.read_file "resources/day12.txt" |> Utilities.parse_char_input
  in
  print_newline ();
  print_endline "----------------- Day 12 -----------------";
  print_newline ();
  print_endline "Part 1";
  print_newline ();
  print_int (search_path [ 'S' ] input);
  print_newline ();
  print_newline ();
  let t2 = Sys.time () in
  print_endline ("Time: " ^ string_of_float (t2 -. t1) ^ "s");
  print_newline ();
  print_endline "Part 2";
  print_newline ();
  print_int (search_path [ 'S'; 'a' ] input);
  print_newline ();
  print_newline ();
  print_endline ("Time: " ^ string_of_float (Sys.time () -. t2) ^ "s");
  print_newline ()
