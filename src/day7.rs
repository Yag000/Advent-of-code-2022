use std::{collections::HashMap, fs};

const THRESHOLD: u32 = 100_000;

const UPDATE_SPACE: u32 = 30_000_000;
const TOTAL_SPACE: u32 = 70_000_000;

pub fn run() {
    println!("Day 7");

    let path = "resources/day7.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    let map = parse(&contents);

    println!("Part 1");
    day7_1(&map);

    println!("Part 2");
    day7_2(&map);
}

fn parse(contents: &str) -> HashMap<String, u32> {
    let mut map = HashMap::new();

    let mut current = "".to_string();

    for line in contents
        .lines()
        .filter(|&l| l != "$ ls" && &l[0..3] != "dir")
    {
        match line {
            "$ cd /" => current = ".".to_string(),
            "$ cd .." => {
                let mut split = current.split("/").collect::<Vec<&str>>();
                split.pop();
                current = split.join("/");
            }
            _ if line.starts_with("$ cd ") => {
                current.push('/');
                current.push_str(&line[5..]);
            }
            _ => {
                let size = line
                    .split_whitespace()
                    .next()
                    .unwrap()
                    .parse::<u32>()
                    .unwrap();

                let directory_size = map.entry(current.clone()).or_insert(0);
                *directory_size += size;

                current.match_indices("/").for_each(|(i, _)| {
                    let directory_size = map.entry(current[0..i].to_owned()).or_insert(0);
                    *directory_size += size;
                });
            }
        }
    }

    map
}

fn day7_1(map: &HashMap<String, u32>) {
    let value = map.values().filter(|x| x <= &&THRESHOLD).sum::<u32>();

    println!("The value is {}", value);
}

fn day7_2(map: &HashMap<String, u32>) {
    let needed = UPDATE_SPACE - (TOTAL_SPACE - map["."]);
    let value = map.values().filter(|&x| x >= &needed).min().unwrap();

    println!("The value is {}", value);
}
