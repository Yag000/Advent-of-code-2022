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

let get_min list =
  let rec aux lastMax = function
    | [] -> lastMax
    | value :: l -> if (value < lastMax)
                    then aux value l
                    else aux lastMax l
  in aux max_int list
;;

let replace new_value list =
  let min_value = get_min list in 
  let rec aux new_list = function
  |[] -> new_list
  |value :: l -> if value = min_value 
                  then aux (new_value::new_list) l
                  else aux (value::new_list) l
  in if min_value <  new_value
      then aux [] list
      else list 
;;

let init_list n =
  let rec aux list = function
    | 0 -> list
    | n -> aux (min_int-n::list) (n-1)
  in aux [] n
;;

let get_top_max n list =
  let rec aux temporal_max = function
    | [] -> temporal_max
    | value :: l -> aux (replace value temporal_max) l
  in aux (init_list n) list
;;

let print_int_list list =
      List.iter (fun value -> print_int value; print_newline ()) list 
;;

let run () = 
Utilities.read_file "ressources/Day1/input.txt" |> get_calories_list |> get_top_max 3 |> print_int_list
;;
