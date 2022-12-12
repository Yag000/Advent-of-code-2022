let () =
  let t1 = Sys.time () in
  print_newline ();
  print_endline "----------------- Day 3 -----------------";
  print_newline ();
  print_endline "Part 1";
  print_newline ();
  Day3_1.run ();
  print_newline ();
  print_newline ();
  let t2 = Sys.time () in
  print_endline ("Time: " ^ string_of_float (t2 -. t1) ^ "s");
  print_newline ();
  print_endline "Part 2";
  print_newline ();
  Day3_2.run ();
  print_newline ();
  print_newline ();
  print_endline ("Time: " ^ string_of_float (Sys.time () -. t2) ^ "s")