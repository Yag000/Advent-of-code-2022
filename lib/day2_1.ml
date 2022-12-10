module type MOVE = sig
  (* The `MOVE` module type defines the types and functions for a game of rock-paper-scissors. *)
  type move = ROCK | PAPER | SCISSORS
end

module Move : MOVE = struct
  (* The `Move` module is an implementation of the `MOVE` module type. *)
  type move = ROCK | PAPER | SCISSORS
  (* The `move` type represents the possible moves in a game of rock-paper-scissors. *)
end

(* **
   * The `string_to_move` function takes a string as input and returns the corresponding `move`.
   *
   * The string is expected to be one of "A", "B", "C", "X", "Y", or "Z".
   * If the input string is not one of these, the function raises the `Invalid_argument` exception.
*)
let string_to_move (s : string) : Move.move =
  match s with
  | "A" | "X" -> ROCK
  | "B" | "Y" -> PAPER
  | "C" | "Z" -> SCISSORS
  | _ -> failwith "invalid move"

(* **
   * The `get_round_result_player_one` function takes a pair of `move` values and returns an integer representing the outcome of the round for player one.
   *
   * If player one wins the round, the function returns 0.
   * If the round is a draw, the function returns 3.
   * Otherwise, the function returns 6.
   * *)
let get_round_result_player_one (move : Move.move * Move.move) : int =
  match move with
  | ROCK, ROCK | SCISSORS, SCISSORS | PAPER, PAPER -> 3
  | ROCK, SCISSORS | SCISSORS, PAPER | PAPER, ROCK -> 0
  | _ -> 6

(* **
   * The `get_points_from_move` function takes a `move` value and returns the number of points associated with that move.
   *
   * If the move is `ROCK`, the function returns 1.
   * If the move is `PAPER`, the function returns 2.
   * If the move is `SCISSORS`, the function returns 3.
   * *)
let get_points_from_move (move : Move.move) : int =
  match move with ROCK -> 1 | PAPER -> 2 | SCISSORS -> 3

(* **
   * The `treat_string` function takes a string as input and returns an integer representing the outcome of a round of the game.
   *
   * The input string is expected to have the form "A <move>" where <move> is one of "A", "B", "C", "X", "Y", or "Z".
   * The function returns the result of the round for player one, as computed by the `get_round_result_player_one` function, plus the number of points associated with the move made by player two, as computed by the `get_points_from_move` function.
   * If the input string is not of the expected form, the function raises the `Invalid_argument` exception.
   * *)
let treat_string s =
  let move1 = string_to_move (String.sub s 0 1) in
  let move2 = string_to_move (String.sub s 2 1) in
  get_points_from_move move2 + get_round_result_player_one (move1, move2)

(* **
   * The `treat_string_list` function takes a list of strings as input and returns an integer representing the outcome of multiple rounds of the game.
   *
   * The function applies the `treat_string` function to each string in the input list and sums the results to compute the overall outcome of the rounds.
   *
   * The input list is expected to contain strings of the form "A <move>" where <move> is one of "A", "B", "C", "X", "Y", or "Z".
   * If any of the strings in the input list is not of the expected form, the function raises the `Invalid_argument` exception.
   *
   * The function returns an integer representing the total outcome of the rounds for player one, plus the total number of points associated with the moves made by player two.
   *
   * The `treat_string_list` function is implemented using a recursive auxiliary function `aux` that takes an accumulator and the list of strings as arguments.
   * The `aux` function iterates over the list of strings, applying the `treat_string` function to each string and adding the result to the accumulator.
   * When the end of the list is reached, the `aux` function returns the accumulator.
   * The `treat_string_list` function passes the accumulator initialized to 0 and the input list to the `aux` function to compute the total outcome of the rounds.
   *
   * @param l The list of strings to process.
   * @return An integer representing the total outcome of the rounds for player one, plus the total number of points associated with the moves made by player two.
   * *)
let treat_string_list l =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (treat_string h + acc) t
  in
  aux 0 l

let run () =
  Utilities.read_file "resources/day2.txt"
  |> treat_string_list |> string_of_int |> print_endline
