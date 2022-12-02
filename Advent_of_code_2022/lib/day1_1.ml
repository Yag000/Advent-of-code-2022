let get_calories_list list =
  let lines = ref [] in
  let rec aux acc= function
      |[] -> lines := acc :: !lines
      | calories :: l ->
          if (calories = "")
          then (
            lines := acc :: !lines;
            aux 0 l)
          else
              aux (acc + int_of_string calories) l
  in aux 0 list;
  !lines
;;

let get_max list =
  let rec aux lastMax = function
    | [] -> lastMax
    | value :: l -> if (value > lastMax)
                    then aux value l
                    else aux lastMax l
  in aux min_int list
;;

let run () = 
  print_newline();
  Utilities.read_file "resources/Day1/input.txt" |> get_calories_list |> get_max |> print_int
;;
      
