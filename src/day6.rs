use std::collections::HashSet;
use std::fs;

pub fn run() {
    println!("Day 6");

    let path = "resources/day6.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    day6_1(&contents);

    println!("Part 2");
    day6_2(&contents);
}

fn day6_1(contents: &str) {
    finder(contents, 4);
}

fn day6_2(contents: &str) {
    finder(contents, 14);
}

fn finder(contents: &str, size: usize) {
    let mut counter = size;
    let mut slice = String::from("");

    for c in contents.chars() {
        slice.push(c);
        if slice.len() < size {
            continue;
        }

        if (slice.chars().collect::<HashSet<char>>()).len() == size {
            println!("The value is {counter}");
            break;
        }

        counter += 1;
        slice = slice[1..].to_string();
    }
}
