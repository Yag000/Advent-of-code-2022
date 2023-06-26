use std::collections::HashSet;
use std::fs;

pub fn run() {
    println!("Day 3");

    let path = "resources/day3.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    day3_1(&contents);

    println!("Part 2");
    day3_2(&contents);
}

fn day3_1(contents: &str) {
    let mut priority = 0;

    for line in contents.lines() {
        let stack_size = line.len() / 2;
        let part1 = &line[0..stack_size];
        let part2 = &line[stack_size..line.len()];
        let part1_chars: HashSet<char> = part1.chars().collect();

        for c in part2.chars() {
            if part1_chars.contains(&c) {
                priority += get_priority(&c);
                break;
            }
        }
    }

    println!("The priority is {priority}");
}

fn day3_2(contents: &str) {
    let mut priority = 0;
    let mut current_line_stack_pos = 0;
    let mut current_candidates: HashSet<char> = HashSet::new();

    for line in contents.lines() {
        let characters: HashSet<char> = line.chars().collect();
        match current_line_stack_pos {
            0 => {
                current_candidates = characters;
                current_line_stack_pos += 1;
            }
            1 => {
                current_candidates = current_candidates
                    .intersection(&characters)
                    .cloned()
                    .collect();
                current_line_stack_pos += 1;
            }
            _ => {
                current_candidates = current_candidates
                    .intersection(&characters)
                    .cloned()
                    .collect();
                for c in current_candidates.iter() {
                    // Should only contain a single element
                    priority += get_priority(&c);
                }
                current_line_stack_pos = 0;
            }
        }
    }

    println!("The priority is {priority}");
}

fn get_priority(c: &char) -> u32 {
    let ascci_value = *c as u32;

    if ascci_value >= 65 && ascci_value <= 90 {
        return ascci_value - 64 + 26;
    } else if ascci_value >= 97 && ascci_value <= 122 {
        return ascci_value - 96;
    } else {
        panic!("Invalid character: {c}");
    }
}
