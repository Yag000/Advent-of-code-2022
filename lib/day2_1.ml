type move = ROCK | PAPER | SCISSORS

let string_to_move = function
  | "A" | "X" -> ROCK
  | "B" | "Y" -> PAPER
  | "C" | "Z" -> SCISSORS
  | _ -> failwith "invalid move"

let get_round_result_player_one = function
  | ROCK, ROCK | SCISSORS, SCISSORS | PAPER, PAPER -> 3
  | ROCK, SCISSORS | SCISSORS, PAPER | PAPER, ROCK -> 0
  | _ -> 6

let get_points_from_move = function ROCK -> 1 | PAPER -> 2 | SCISSORS -> 3

let treat_string s =
  let move1 = string_to_move (String.sub s 0 1) in
  let move2 = string_to_move (String.sub s 2 1) in
  get_points_from_move move2 + get_round_result_player_one (move1, move2)

let treat_string_list l =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (treat_string h + acc) t
  in
  aux 0 l

let run () =
  Utilities.read_file "resources/day2_input.txt"
  |> treat_string_list |> string_of_int |> print_endline
