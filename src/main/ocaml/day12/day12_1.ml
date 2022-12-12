open Lib

let is_movement_possible map x y next_x next_y last_movements =
  if
    next_x < 0
    || next_x >= Array.length map
    || next_y < 0
    || next_y >= Array.length map.(0)
  then false
  else
    map.(next_x).(next_y) <= map.(x).(y) + 1
    && not (List.mem (next_x, next_y) last_movements)

let all_possible map x y last_movements =
  if x < 0 || x >= Array.length map || y < 0 || y >= Array.length map.(0) then
    []
  else
    let rec aux acc = function
      | [] -> acc
      | (next_x, next_y) :: t ->
          if is_movement_possible map x y next_x next_y last_movements then
            aux ((next_x, next_y) :: acc) t
          else aux acc t
    in
    aux [] [ (x + 1, y); (x - 1, y); (x, y + 1); (x, y - 1) ]

let rec backtrack map (x, y) last_movements solutions =
  if map.(x).(y) = -1 then
    if List.length last_movements < Utilities.get_min solutions then
      [ List.length last_movements ]
    else [ Utilities.get_min solutions ]
  else
    let rec aux = function
      | [] -> []
      | (next_x, next_y) :: t ->
          [
            Utilities.get_min
              (backtrack map (next_x, next_y)
                 ((next_x, next_y) :: last_movements)
                 solutions
              @ aux t @ solutions);
          ]
    in
    if List.length last_movements >= Utilities.get_min solutions then []
    else aux (all_possible map x y last_movements)

let parse_input input =
  let starting_pos = ref (0, 0) in
  let rec aux list i array =
    match list with
    | [] -> array
    | h :: t ->
        String.iteri
          (fun j c ->
            array.(i).(j) <-
              (if c = 'S' then (
               starting_pos := (i, j);
               0)
              else if c = 'E' then -1
              else int_of_char c - 96))
          h;
        aux t (i + 1) array
  in
  let array =
    Array.make_matrix (List.length input) (String.length (List.hd input)) 0
  in
  (aux input 0 array, starting_pos)

let () =
  let input, start = Utilities.read_file "resources/day12.txt" |> parse_input in
  input.(fst !start).(snd !start) <- 1;
  backtrack input !start [ !start ] [ max_int ]
  |> List.iter (fun x ->
         print_int x;
         print_newline ())
