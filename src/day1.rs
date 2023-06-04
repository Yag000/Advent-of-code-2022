use std::fs;

fn main() {
    let file_path = "resources/day1.txt";

    let contents = fs::read_to_string(file_path).expect("Should have been able to read the file");

    let mut max_calories = [0; 3];
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
