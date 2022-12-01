let read_file filename = 
  let lines = ref [] in
  let chan = open_in filename in
  try
    while true; do
      lines :=  input_line chan :: !lines;
    done; !lines
  with End_of_file ->
    close_in chan;
    List.rev !lines ;;

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

let get_max list =
  let rec aux lastMax = function
    | [] -> lastMax
    | value :: l -> if (value > lastMax)
                    then aux value l
                    else aux lastMax l
  in aux min_int list;;

let () = read_file "input.txt" |> get_calories_list |> get_max |> print_int
      
