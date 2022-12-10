open Lib

(* **
   * [treat_input first_cycle cycle_length last_cycle list] is a function that
   * processes the list of inputs in [list]. The first cycle in which the register
   * value is added to the total sum is [first_cycle], and this continues until
   * [last_cycle]. The register value is added to the total sum every [cycle_length]
   * cycles.
   *
   * - requires: [first_cycle], [cycle_length], and [last_cycle] must be non-negative
   *             and [last_cycle] must be greater than or equal to [first_cycle]
   *             [list] must not be empty and must only contain strings in the
   *             format "addx NUMBER" or "add NUMBER" where NUMBER is an integer
   * - returns: the total sum after processing the input list
   * *)
let treat_input first_cycle cycle_length last_cycle list =
  let rec aux cycle register_value total_sum = function
    | [] -> total_sum
    | s :: t -> (
        let new_sum =
          if cycle mod cycle_length = first_cycle && cycle <= last_cycle then
            total_sum + (cycle * register_value)
          else total_sum
        in
        if cycle >= last_cycle then new_sum
        else
          match String.split_on_char ' ' s with
          | [ "addx"; number ] ->
              aux (cycle + 1) register_value new_sum (("add " ^ number) :: t)
          | [ "add"; number ] ->
              aux (cycle + 1) (register_value + int_of_string number) new_sum t
          | _ -> aux (cycle + 1) register_value new_sum t)
  in
  aux 1 1 0 list

let run () =
  Utilities.read_file "resources/day10.txt"
  |> treat_input 20 40 220 |> print_int
