open Lib

(* get_winning_move: returns the move that would win against the given move *)
let get_winning_move (move : Day2_1.Move.move) : Day2_1.Move.move =
  match move with ROCK -> PAPER | PAPER -> SCISSORS | SCISSORS -> ROCK

(* get_loosing_move: returns the move that would lose against the given move *)
let get_loosing_move (move : Day2_1.Move.move) : Day2_1.Move.move =
  match move with PAPER -> ROCK | ROCK -> SCISSORS | SCISSORS -> PAPER

(* instruction_to_move: returns the move indicated by the given instruction, based on the given move *)
let instruction_to_move move = function
  | "X" -> get_loosing_move move
  | "Y" -> move
  | "Z" -> get_winning_move move
  | _ -> failwith "Invalid instruction"

(* get_round_result_player_one: returns the points awarded to player one for the given moves in a round *)
let get_round_result_player_one (move : Day2_1.Move.move * Day2_1.Move.move) :
    int =
  match move with
  | ROCK, ROCK | SCISSORS, SCISSORS | PAPER, PAPER -> 3
  | ROCK, SCISSORS | SCISSORS, PAPER | PAPER, ROCK -> 0
  | _ -> 6

(* treat_string: treats a string representing a single round and returns the points awarded in that round *)
let treat_string s =
  let move1 = Day2_1.string_to_move (String.sub s 0 1) in
  let move2 = instruction_to_move move1 (String.sub s 2 1) in
  Day2_1.get_points_from_move move2 + get_round_result_player_one (move1, move2)

(* treat_string_list: treats a list of strings representing rounds and returns the total points awarded *)
let treat_string_list l =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (treat_string h + acc) t
  in
  aux 0 l

let run () =
  Utilities.read_file "resources/day2.txt"
  |> treat_string_list |> string_of_int |> print_endline
