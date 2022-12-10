let print_image list =
  let rec aux i = function
    | [] -> ()
    | b :: t ->
        if i mod 40 = 0 then print_newline () else ();
        if b then print_string "#" else print_string ".";
        aux (i + 1) t
  in
  aux 0 list

let treat_input cycle_length last_cycle list =
  let rec aux cycle register_value pixels = function
    | [] -> pixels
    | s :: t -> (
        let new_pixels =
          (cycle mod cycle_length <= register_value + 1
          && cycle mod cycle_length >= register_value - 1)
          :: pixels
        in
        if cycle >= last_cycle then new_pixels
        else
          match String.split_on_char ' ' s with
          | [ "addx"; number ] ->
              aux (cycle + 1) register_value new_pixels (("add " ^ number) :: t)
          | [ "add"; number ] ->
              aux (cycle + 1)
                (register_value + int_of_string number)
                new_pixels t
          | _ -> aux (cycle + 1) register_value new_pixels t)
  in
  aux 0 1 [] list

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day10_input.txt"
  |> treat_input 40 240 |> List.rev |> print_image;
  print_newline ()
