type int_pair = Pair of int * int


module IntPair = struct
  type t = int_pair

  let compare (Pair (x1, y1)) (Pair (x2, y2)) =
    if x1 = x2 && y1 = y2 then 0 else 1
end

module Tuples = Set.Make (IntPair)

let compute_index i j is_row is_reversed array =
  match (is_row, is_reversed) with
  | true, true -> Pair (Array.length array - i, j)
  | true, false -> Pair (i, j)
  | false, true -> Pair (Array.length array.(j) - j, i)
  | false, false -> Pair (j, i)

let get_visible_list index is_row is_reversed list array set =
  let visible, _ =
    List.fold_left
      (fun (acc, pos) i ->
        if List.for_all (fun (_, x) -> x < i) acc then
          ((compute_index index pos is_row is_reversed array, i) :: acc, pos + 1)
        else (acc, pos + 1))
      ([], 0) list
  in
  List.fold_left (fun acc (x, _) -> Tuples.add x acc) set visible

let array2D_to_list index is_row array =
  if is_row then Array.to_list array.(index)
  else
    let res = ref [] in
    for i = 0 to Array.length array do
      res := array.(i).(index) :: !res
    done;
    !res

let get_visible array =
  let set = ref Tuples.empty in
  let nb_of_lines = Array.length array in
  let nb_of_columns = Array.length array.(0) in
  for i = 0 to nb_of_lines - 1 do
    set :=
      get_visible_list i true false (array2D_to_list i true array) array !set
  done;
  for j = 0 to nb_of_columns do
    set :=
      get_visible_list j false false (array2D_to_list j false array) array !set
  done;

  for i = 0 to nb_of_lines - 1 do
    set :=
      get_visible_list i true true
        (array2D_to_list i true array |> List.rev)
        array !set
  done;
  for j = 0 to nb_of_columns do
    set :=
      get_visible_list j false true
        (array2D_to_list j false array |> List.rev)
        array !set
  done;
  !set

let treat_input list =
  get_visible (Utilities.parse_int_input list) |> Tuples.cardinal

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day8.txt" |> treat_input |> print_int;
  print_newline ()
