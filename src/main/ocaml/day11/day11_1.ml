open Lib

type operation = int -> int

type monkey = {
  id : int;
  items : int list;
  operation : operation;
  test : int;
  if_true : int;
  if_false : int;
}

let add_item monkey item = { monkey with items = item :: monkey.items }

let update_monkey id monkeys inspected =
  let monkey = monkeys.(id) in
  inspected.(id) <- inspected.(id) + List.length monkey.items;
  List.iter
    (fun item ->
      let new_value = monkey.operation item / 3 in
      if new_value mod monkey.test = 0 then
        monkeys.(monkey.if_true) <- add_item monkeys.(monkey.if_true) new_value
      else
        monkeys.(monkey.if_false) <-
          add_item monkeys.(monkey.if_false) new_value)
    monkey.items

let round monkeys inspected =
  Array.iteri (fun id _ -> update_monkey id monkeys inspected) monkeys

let rec run monkeys inspected max_rounds =
  if max_rounds = 0 then inspected
  else (
    round monkeys inspected;
    run monkeys inspected (max_rounds - 1))

let get_business n inspected =
  Utilities.get_top_max n (Array.to_list inspected) |> List.fold_left ( * ) 1

let get_items_from_string_list =
  let rec aux acc = function
    | [] -> acc
    | [ x ] -> (
        print_endline "i'm not happy";
        try int_of_string x :: acc with Failure _ -> acc)
    | x :: rest ->
        print_endline "yes";
        aux
          ((String.sub x 0 (String.length x - 1) |> int_of_string) :: acc)
          rest
  in
  aux []

let parse_line monkey size list =
  try
    match list with
    | "Monkey" :: _ ->
        print_int size;
        print_endline "Monkey";
        (false, { monkey with id = size })
    | "" :: "" :: "Starting" :: "items:" :: items ->
        print_endline "starting items";
        List.iter
          (fun x ->
            print_int x;
            print_string ", ")
          (get_items_from_string_list items);
        print_newline ();
        (false, { monkey with items = get_items_from_string_list items })
    | "" :: "" :: "Operation:" :: "new" :: "=" :: "old" :: operator :: number
      :: _ ->
        print_endline operator;
        ( false,
          {
            monkey with
            operation =
              (fun x ->
                if operator = "+" then x + int_of_string number
                else x * int_of_string number);
          } )
    | "" :: "" :: "Test:" :: "divisible" :: "by" :: number :: _ ->
        print_string "divisible by ";
        print_endline number;
        (false, { monkey with test = int_of_string number })
    | "" :: "" :: "" :: "" :: "If" :: "true:" :: "throw" :: "to" :: "monkey"
      :: number :: _ ->
        print_string "if true throw to ";
        print_endline number;
        (false, { monkey with if_true = int_of_string number })
    | "" :: "" :: "" :: "" :: "If" :: "false:" :: "throw" :: "to" :: "monkey"
      :: number :: _ ->
        print_string "if false throw to ";
        print_endline number;
        print_int (int_of_string number);
        (false, { monkey with if_false = int_of_string number })
    | _ -> (true, monkey)
  with Failure _ -> (true, monkey)

let parse_input input =
  let rec aux input size monkeys monkey =
    match input with
    | [] -> monkeys
    | line :: rest ->
        let needs_update, new_monkey =
          parse_line monkey size (String.split_on_char ' ' line)
        in
        if needs_update then (
          monkeys.(size) <- new_monkey;
          aux rest (size + 1) monkeys new_monkey)
        else aux rest size monkeys new_monkey
  in

  aux input 0
    (Array.make 8
       {
         id = 0;
         items = [];
         operation = (fun x -> x);
         test = 0;
         if_true = 0;
         if_false = 0;
       })
    {
      id = 0;
      items = [];
      operation = (fun x -> x);
      test = 0;
      if_true = 0;
      if_false = 0;
    }

let run () =
  let input = Utilities.read_file "resources/day11.txt" in
  let monkeys = parse_input input in
  let inspected = run monkeys (Array.make 8 0) 20 in
  get_business 2 inspected |> print_int