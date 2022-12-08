type move = ROCK | PAPER | SCISSORS

let get_winning_move = function
  | ROCK -> PAPER
  | PAPER -> SCISSORS
  | SCISSORS -> ROCK

let get_loosing_move = function
  | PAPER -> ROCK
  | ROCK -> SCISSORS
  | SCISSORS -> PAPER

let instruction_to_move move = function
  | "X" -> get_loosing_move move
  | "Y" -> move
  | "Z" -> get_winning_move move
  | _ -> failwith "Invalid instruction"

let string_to_move = function
  | "A" -> ROCK
  | "B" -> PAPER
  | "C" -> SCISSORS
  | _ -> failwith "invalid move"

let get_round_result_player_one = function
  | ROCK, ROCK | SCISSORS, SCISSORS | PAPER, PAPER -> 3
  | ROCK, SCISSORS | SCISSORS, PAPER | PAPER, ROCK -> 0
  | _ -> 6

let get_points_from_move = function ROCK -> 1 | PAPER -> 2 | SCISSORS -> 3

let treat_string s =
  let move1 = string_to_move (String.sub s 0 1) in
  let move2 = instruction_to_move move1 (String.sub s 2 1) in
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
