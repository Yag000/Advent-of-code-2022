let read_file filename = 
  let lines = ref [] in
  let channel = open_in filename in
  try
    while true; do
      lines :=  input_line channel :: !lines;
    done; !lines
  with End_of_file ->
    close_in channel;
    List.rev !lines 
;;