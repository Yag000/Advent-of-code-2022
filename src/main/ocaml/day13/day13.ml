open Lib

type deep_list = I of int | L of deep_list list
type info = Empty | Start of info | End of info | In of int

let rec string_to_deep_list s =
  match s with
  | [] -> []
  | Empty :: t -> L [] :: string_to_deep_list t
  | In x :: t -> I x :: string_to_deep_list t
  | Start info :: t -> L (string_to_deep_list [ info ]) :: string_to_deep_list t
  | End info :: t -> string_to_deep_list [ info ] @ string_to_deep_list t

let rec print_deep_list = function
  | I n ->
      print_int n;
      print_string " ,"
  | L list ->
      print_string "[";
      List.iter
        (fun x ->
          print_deep_list x;
          print_string " ,")
        list;
      print_string "]"

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
  print_newline ();
  print_newline ();
  print_newline ();
  print_newline ();
  string_to_deep_list
    "[[],[],[[],10,[[7,0,1,1,10],9,6],[1,[4,9,1],6,[4,6,0]],[0,3,0]],[1,[10,[7,4,3,4],[]],[2,2],7,[[10],5,3]]]\n\
    \  "
  |> print_deep_list
