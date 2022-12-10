type file = File of string * int
type temp_list = List of string * string list * file list
type folder = Folder of string * folder list * file list

(* TODO: some "/" are missing... (after a cd)*)
module Temp_List = struct
  type t = temp_list

  let compare (List (name1, _, _)) (List (name2, _, _)) =
    String.compare name1 name2

  let print (List (name, _, _)) = print_endline name
end

module Folders = Set.Make (Temp_List)

let create_tmp_list dir_name values =
  let rec aux (folder_names, files) = function
    | (name, 0) :: t -> aux ((dir_name ^ name) :: folder_names, files) t
    | (name, size) :: t ->
        aux (folder_names, File (dir_name ^ name, size) :: files) t
    | _ -> (folder_names, files)
  in
  let folder_names, files = aux ([], []) values in
  List (dir_name, folder_names, files)

let get_element_info = function
  | [ "dir"; name ] -> (name, 0)
  | [ size; name ] -> (name, int_of_string size)
  | _ -> ("", 0)

let treat_string_output s = String.split_on_char ' ' s |> get_element_info

let treat_list_output =
  List.fold_left (fun acc s -> treat_string_output s :: acc) []

let get_new_folder name values =
  treat_list_output values |> create_tmp_list name

let remove_last_suffix c s =
  let rec aux acc = function
    | [] -> acc
    | [ _ ] -> acc
    | h :: t -> aux (acc ^ h) t
  in
  let res = String.split_on_char c s |> aux "" in
  if res = "" then "/" else res

let get_new_name dirname = function
  | "/" :: _ -> "/"
  | ".." :: _ -> remove_last_suffix '/' dirname
  | name :: _ -> if dirname == "/" then "/" ^ name else dirname ^ "/" ^ name
  | _ -> dirname

let treat_command command_name output dir_name set =
  match command_name with
  | "cd" :: t -> (get_new_name dir_name t, set)
  | "ls" :: _ -> (dir_name, Folders.add (get_new_folder dir_name output) set)
  | _ -> (dir_name, set)

let generate_arborescence set =
  let rec aux name =
    let (List (_, folder_names, files)) =
      Folders.find (List (name, [], [])) set
    in
    Folder
      ( name,
        List.map
          (fun s -> aux (if name = "/" then s else name ^ "/" ^ s))
          folder_names,
        files )
  in
  aux "/"

let treat_input list =
  let rec aux name command output set = function
    | [] -> set
    | s :: t -> (
        print_endline s;
        Folders.iter Temp_List.print set;
        match String.split_on_char ' ' s with
        | "$" :: "cd" :: new_command ->
            let new_name, new_set = treat_command command output name set in
            List.fold_left ( ^ ) "" command |> print_endline;
            print_endline new_name;
            print_endline new_name;
            Folders.iter Temp_List.print set;
            aux new_name ("cd" :: new_command) [] new_set t
        | "$" :: "ls" :: _ ->
            let new_name, new_set = treat_command command output name set in
            aux new_name [ "ls" ] [] new_set t
        | [ value1; value2 ] ->
            print_endline "yes";
            aux name command ((value1 ^ " " ^ value2) :: output) set t
        | _ ->
            print_endline "problem...";
            aux name command output set t)
  in
  let res = aux "/" [ "cd" ] [] Folders.empty list in
  Folders.iter Temp_List.print res;
  res

let rec compute_sum max_size folder =
  let (Folder (_, folders, files)) = folder in
  let sum_files =
    List.fold_left
      (fun acc file ->
        let (File (_, size)) = file in
        acc + size)
      0 files
  in
  if sum_files > max_size then 0
  else
    let sum_folders =
      List.fold_left
        (fun acc folder -> acc + compute_sum max_size folder)
        0 folders
    in
    if sum_files + sum_folders > max_size then 0 else sum_files + sum_folders

let run () =
  print_newline ();
  print_newline ();
  Utilities.read_file "resources/day7.txt"
  |> treat_input |> generate_arborescence |> compute_sum 100000 |> print_int;
  print_newline ()
