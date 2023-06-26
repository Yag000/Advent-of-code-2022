use std::fs;

pub fn run() {
    println!("Day 1");

    let path = "resources/day1.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    get_sum_max_elements(&contents, 1);

    println!("Part 2");
    get_sum_max_elements(&contents, 3);
}


fn get_sum_max_elements(contents: &str, n: u32) {
    let mut max_calories: Vec<u32> = Vec::new(); // I need vectors to do this...
    for _ in 0..n{
        max_calories.push(0);
    }
    let mut subtotal = 0;

    for line in contents.lines() {
        match line.parse::<u32>() {
            Ok(value) => subtotal += value,
            Err(_) => {
                add_to_values(&mut max_calories, subtotal);
                subtotal = 0
            }
        };
    }
        
    let mut max = 0;
    for value in max_calories {
        max += value;
    }
        
    println!("The max caloriees is: {max}");
}

fn add_to_values(values: &mut Vec<u32>, subtotal: u32) {
    for (i, value) in values.iter().enumerate() {
        if subtotal <= *value {
            continue;
        }

        values[i] = subtotal;
        // shift the rest of the array
        for j in i + 1..values.len() {
            values[j] = values[j - 1];
        }
        break;
    }
}
