use std::fs;

#[derive(Debug, Clone)]
enum Move {
    Rock,
    Paper,
    Scissors,
}

pub fn run() {
    println!("Day 2");
    let path = "resources/day2.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    day2_1(&contents);

    println!("Part 2");
    day2_2(&contents);
}

fn day2_1(contents: &str) {
    let mut points = 0;
    for line in contents.lines() {
        assert!(line.len() >= 3);
        //dbg!(&line);
        let mut line = line.split(" ");
        //dbg!(&line);
        let player1 = get_move_1(line.next());
        let player2 = get_move_1(line.next());
        //dbg!(&player1);
        //dbg!(&player2);

        points += get_points(player1, player2);
    }

    println!("The points are {points}")
}

fn get_move_1(s: Option<&str>) -> Move {
    match s {
        Some(value) => match value {
            "A" | "X" => Move::Rock,
            "B" | "Y" => Move::Paper,
            "C" | "Z" => Move::Scissors,
            _ => panic!("Invalid move: {value}"),
        },

        None => panic!("invalid input"),
    }
}

fn day2_2(contents: &str) {
    let mut points = 0;
    for line in contents.lines() {
        assert!(line.len() >= 3);
        //dbg!(&line);
        let mut line = line.split(" ");
        //dbg!(&line);
        let player1 = get_move_1(line.next());
        let player2 = get_move_2(&player1, line.next());
        //dbg!(&player1);
        //dbg!(&player2);

        points += get_points(player1, player2);
    }

    println!("The points are {points}")
}

fn get_move_2(move_: &Move, s: Option<&str>) -> Move {
    match s {
        Some(value) => match value {
            "X" => get_losoing(move_),
            "Y" => move_.clone(),
            "Z" => get_winning(move_),
            _ => panic!("Invalid move: {value}"),
        },

        None => panic!("invalid input"),
    }
}

fn get_winning(move_: &Move) -> Move {
    match move_ {
        Move::Rock => Move::Paper,
        Move::Paper => Move::Scissors,
        Move::Scissors => Move::Rock,
    }
}
fn get_losoing(move_: &Move) -> Move {
    match move_ {
        Move::Rock => Move::Scissors,
        Move::Paper => Move::Rock,
        Move::Scissors => Move::Paper,
    }
}

fn get_points(a: Move, b: Move) -> u32 {
    let value = match (a, &b) {
        (Move::Rock, Move::Rock)
        | (Move::Paper, Move::Paper)
        | (Move::Scissors, Move::Scissors) => 3,
        (Move::Rock, Move::Scissors)
        | (Move::Scissors, Move::Paper)
        | (Move::Paper, Move::Rock) => 0,
        _ => 6,
    };
    value
        + match b {
            Move::Rock => 1,
            Move::Paper => 2,
            Move::Scissors => 3,
        }
}
