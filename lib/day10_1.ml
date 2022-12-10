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
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day10_input.txt"
  |> treat_input 20 40 220 |> print_int;
  print_newline ()
