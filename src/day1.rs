use std::fs;

pub fn run() {
    println!("Day 1");

    let path = "resources/day1.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");
    
    println!("Part 1");
    day1_1(&contents);

    println!("Part 2");
    day1_2(&contents);
}

fn day1_1 (contents:&str) {
    let mut max_calories = 0; // I need vectors to do this...
    let mut subtotal = 0;

    for line in contents.lines() {
        match line.parse::<u32>() {
            Ok(value) => subtotal += value,
            Err(_) => {
                if subtotal > max_calories {
                    max_calories = subtotal;
                }
                subtotal = 0
            }
        };
    }

    println!("The max caloriees is: {max_calories}");
}


fn day1_2 (contents: &str) {
    let mut max_calories = [0; 3]; // I need vectors to do this...
    let mut subtotal = 0;

    for line in contents.lines() {
        match line.parse::<u32>() {
            Ok(value) => subtotal += value,
            Err(_) => {
                add_to_max_list(&mut max_calories, subtotal);
                subtotal = 0
            }
        };
    }

    let max = max_calories[0] + max_calories[1] + max_calories[2];

    println!("The max caloriees is: {max}");
}

fn add_to_max_list(array: &mut [u32], subtotal: u32) {
    for (i, value) in array.iter().enumerate() {
        if subtotal <= *value {
            continue;
        }

        array[i] = subtotal;
        // shift the rest of the array
        for j in i + 1..array.len() {
            array[j] = array[j - 1];
        }
        break;
    }
}
