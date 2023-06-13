use std::fs;

#[derive(Debug)]
struct Stacks {
    number: usize,
    stack: Vec<Vec<char>>,
}

impl Stacks {
    fn new(number: usize) -> Stacks {
        let mut stack: Vec<Vec<char>> = Vec::new();

        for _ in 0..number {
            stack.push(Vec::new());
        }

        Stacks {
            number,
            stack: stack,
        }
    }

    fn push(self: &mut Self, position: usize, value: char) {
        self.stack[position].push(value);
    }

    fn append(self: &mut Self, position: usize, value: &mut Vec<char>) {
        self.stack[position].append(value);
    }
    fn pop(self: &mut Self, position: usize) -> char {
        self.stack[position].pop().unwrap()
    }

    fn peek(self: &Self, position: usize) -> char {
        let height = self.stack[position].len() - 1;
        self.stack[position][height]
    }

    fn get_code(self: &Self) -> String {
        let mut code = String::new();
        for i in 0..self.number {
            code.push(self.peek(i));
        }
        code
    }

    fn reverse(self: &mut Self) {
        for colunm in &mut self.stack {
            colunm.reverse();
        }
    }

    fn pop_last_n(self: &mut Self, position: usize, n: usize) -> Vec<char> {
        let mut result: Vec<char> = Vec::new();
        for _ in 0..n {
            result.push(self.pop(position));
        }
        result.reverse();
        result

    }
}

pub fn run() {
    println!("Day 5");

    let path = "resources/day5.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    day5_1(&contents);

    println!("Part 2");
    day5_2(&contents);
}

fn day5_1(contents: &str) {
    let mut stacks = Stacks::new(9); // Hardcoded for the input (i'm laazy)

    let mut initing = true;

    for line in contents.lines() {
        if initing {
            if line == " 1   2   3   4   5   6   7   8   9 " {
                initing = false;
                stacks.reverse();
                continue;
            }
            parse_init_line(&mut stacks, line);
            continue;
        }

        parse_move(&mut stacks, line);
    }

    println!("The code is {code}", code = stacks.get_code());
}

fn parse_init_line(stacks: &mut Stacks, line: &str) {
    let mut i = 0;
    let mut number_of_spaces = 0;
    for element in line.split(" ").collect::<Vec<&str>>() {
        if element == "" {
            number_of_spaces += 1;
            if number_of_spaces == 4 {
                i += 1;
                number_of_spaces = 0;
            }
            continue;
        }
        let current_char: char = element.chars().collect::<Vec<char>>()[1];
        stacks.push(i, current_char);
        i += 1;
    }
}

fn parse_move(stacks: &mut Stacks, line: &str) {
    if line == "" {
        return;
    }
    let values = line.split(" ").collect::<Vec<&str>>();
    let number: usize = values[1].parse().unwrap();
    let initial_position: usize = values[3].parse().unwrap();
    let final_position: usize = values[5].parse().unwrap();

    for _ in 00..number {
        let value = stacks.pop(initial_position - 1);
        stacks.push(final_position - 1, value);
    }
}

fn day5_2(contents: &str) {
    let mut stacks = Stacks::new(9); // Hardcoded for the input (i'm laazy)

    let mut initing = true;

    for line in contents.lines() {
        if initing {
            if line == " 1   2   3   4   5   6   7   8   9 " {
                initing = false;
                stacks.reverse();
                continue;
            }
            parse_init_line(&mut stacks, line);
            continue;
        }

        parse_move_2(&mut stacks, line);
    }

    println!("The code is {code}", code = stacks.get_code());
}

fn parse_move_2(stacks: &mut Stacks, line: &str) {
    if line == "" {
        return;
    }
    let values = line.split(" ").collect::<Vec<&str>>();
    let number: usize = values[1].parse().unwrap();
    let initial_position: usize = values[3].parse().unwrap();
    let final_position: usize = values[5].parse().unwrap();

    let mut value = stacks.pop_last_n( initial_position - 1, number);
    stacks.append(final_position - 1, &mut value);
}
