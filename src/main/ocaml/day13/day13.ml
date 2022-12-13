open Lib

type deep_list = S of int | L of deep_list list

let part1 () = ()
let part2 () = ()

let () =
  let t1 = Sys.time () in
  let _ = Utilities.read_file "resources/day13.txt" in
  print_newline ();
  print_endline "----------------- Day 12 -----------------";
  print_newline ();
  print_endline "Part 1";
  print_newline ();
  part1 ();
  print_newline ();
  print_newline ();
  let t2 = Sys.time () in
  print_endline ("Time: " ^ string_of_float (t2 -. t1) ^ "s");
  print_newline ();
  print_endline "Part 2";
  print_newline ();
  part2 ();
  print_newline ();
  print_newline ();
  print_endline ("Time: " ^ string_of_float (Sys.time () -. t2) ^ "s");
  print_newline ()
