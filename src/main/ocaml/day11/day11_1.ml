open Lib

type operation = int -> int

type monkey = {
  items : int list;
  operation : operation;
  test : int;
  if_true : int;
  if_false : int;
}

let add_item monkey item = { monkey with items = item :: monkey.items }

let update_monkey id monkeys inspected lcm is_part1 =
  let monkey = monkeys.(id) in
  inspected.(id) <- inspected.(id) + List.length monkey.items;
  List.iter
    (fun item ->
      let new_value =
        if is_part1 then monkey.operation item / 3
        else monkey.operation item mod lcm
      in
      if new_value mod monkey.test = 0 then
        monkeys.(monkey.if_true) <- add_item monkeys.(monkey.if_true) new_value
      else
        monkeys.(monkey.if_false) <-
          add_item monkeys.(monkey.if_false) new_value)
    monkey.items;
  monkeys.(id) <- { monkey with items = [] }

let round monkeys inspected lcm is_part1 =
  Array.iteri
    (fun id _ -> update_monkey id monkeys inspected lcm is_part1)
    monkeys

let rec run monkeys inspected max_rounds lcm is_part1 =
  if max_rounds = 0 then inspected
  else (
    round monkeys inspected lcm is_part1;
    run monkeys inspected (max_rounds - 1) lcm is_part1)

let get_business n inspected =
  Utilities.get_top_max n (Array.to_list inspected) |> List.fold_left ( * ) 1

let get_items_from_string_list =
  let rec aux acc = function
    | [] -> acc
    | [ x ] -> int_of_string x :: acc
    | x :: rest ->
        aux
          ((String.sub x 0 (String.length x - 1) |> int_of_string) :: acc)
          rest
  in
  aux []

let parse_line monkey list =
  try
    match list with
    | "Monkey" :: _ -> (false, monkey)
    | "" :: "" :: "Starting" :: "items:" :: items ->
        (false, { monkey with items = get_items_from_string_list items })
    | "" :: "" :: "Operation:" :: "new" :: "=" :: "old" :: operator :: number
      :: _ ->
        ( false,
          {
            monkey with
            operation =
              (fun x ->
                let number_ =
                  if number = "old" then x else int_of_string number
                in
                if operator = "+" then x + number_ else x * number_);
          } )
    | "" :: "" :: "Test:" :: "divisible" :: "by" :: number :: _ ->
        (false, { monkey with test = int_of_string number })
    | "" :: "" :: "" :: "" :: "If" :: "true:" :: "throw" :: "to" :: "monkey"
      :: number :: _ ->
        (false, { monkey with if_true = int_of_string number })
    | "" :: "" :: "" :: "" :: "If" :: "false:" :: "throw" :: "to" :: "monkey"
      :: number :: _ ->
        (false, { monkey with if_false = int_of_string number })
    | _ -> (true, monkey)
  with Failure _ -> (true, monkey)

let parse_input input =
  let rec aux input size lcm monkeys monkey =
    match input with
    | [] ->
        monkeys.(size) <- monkey;
        (lcm, monkeys)
    | line :: rest ->
        let needs_update, new_monkey =
          parse_line monkey (String.split_on_char ' ' line)
        in
        if needs_update then (
          monkeys.(size) <- new_monkey;
          aux rest (size + 1) (lcm * monkey.test) monkeys new_monkey)
        else aux rest size lcm monkeys new_monkey
  in

  aux input 0 1
    (Array.make 8
       {
         items = [];
         operation = (fun x -> x);
         test = 0;
         if_true = 0;
         if_false = 0;
       })
    {
      items = [];
      operation = (fun x -> x);
      test = 0;
      if_true = 0;
      if_false = 0;
    }

let run1 monkeys =
  let inspected = run monkeys (Array.make 8 0) 20 0 true in
  get_business 2 inspected |> print_int

let run2 lcm monkeys =
  let inspected = run monkeys (Array.make 8 0) 10000 lcm false in
  get_business 2 inspected |> print_int

let () =
  let input = Utilities.read_file "resources/day11.txt" in
  let lcm, monkeys = parse_input input in
  run1 monkeys;
  print_newline ();
  run2 lcm monkeys
