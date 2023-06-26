use std::fs;

struct Positions(usize, usize);

pub fn run() {
    println!("Day 8");
    let path = "resources/day8.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    let trees = parse(&contents);

    println!("Part 1");
    day8_1(&trees);

    println!("Part 2");
    day8_2(&trees);
}

fn parse(contents: &str) -> Vec<Vec<char>> {
    contents.lines().map(|x| x.chars().collect()).collect()
}

fn day8_1(trees: &Vec<Vec<char>>) {
    let mut visible = 0;

    trees.iter().enumerate().for_each(|(i, line)| {
        line.iter().enumerate().for_each(|(j, value)| {
            if is_visibble(trees, &Positions(i, j), value) {
                visible += 1;
            }
        })
    });

    println!("The number of visible trees is {visible}");
}

fn is_visibble(trees: &Vec<Vec<char>>, position: &Positions, pos_value: &char) -> bool {
    if trees[position.0][..position.1]
        .iter()
        .all(|x| x < &pos_value)
    {
        return true;
    }
    if trees[position.0][position.1 + 1..]
        .iter()
        .all(|x| x < &pos_value)
    {
        return true;
    }
    if trees[..position.0]
        .iter()
        .all(|x| &x[position.1] < pos_value)
    {
        return true;
    }
    if trees[position.0 + 1..]
        .iter()
        .all(|x| &x[position.1] < pos_value)
    {
        return true;
    }

    return false;
}

fn day8_2(trees: &Vec<Vec<char>>) {
    let value = trees
        .iter()
        .enumerate()
        .flat_map(|(i, line)| {
            line.iter()
                .enumerate()
                .map(move |(j, value)| quality(trees, &Positions(i, j), value))
        })
        .max()
        .unwrap();
    println!("The quality of the best position is {value}");
}

fn quality(trees: &Vec<Vec<char>>, position: &Positions, pos_value: &char) -> u32 {
    let mut quality = (0, 0, 0, 0);

    for element in trees[position.0][..position.1].iter().rev() {
        quality.0 += 1;
        if &element >= &pos_value {
            break;
        }
    }
    for element in trees[position.0][position.1 + 1..].iter() {
        quality.1 += 1;
        if &element >= &pos_value {
            break;
        }
    }

    for element in trees[..position.0].iter().rev() {
        quality.2 += 1;
        if &element[position.1] >= pos_value {
            break;
        }
    }

    for element in trees[position.0 + 1..].iter() {
        quality.3 += 1;
        if &element[position.1] >= pos_value {
            break;
        }
    }

    return quality.0 * quality.1 * quality.2 * quality.3;
}
