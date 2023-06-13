use std::fs;

struct Section(u32, u32);

pub fn run() {
    println!("Day 4");

    let path = "resources/day4.txt";
    let contents = fs::read_to_string(path).expect("Should have been able to read the file");

    println!("Part 1");
    day4_1(&contents);

    println!("Part 2");
    day4_2(&contents);
}

fn day4_1(content: &str) {
    let mut fully_contained = 0;
    for line in content.lines() {
        let (section1, section2) = get_sections(line);
        if is_fully_contained(&section1, &section2) {
            fully_contained += 1;
        }
    }

    println!("The number of fully contained sections is {fully_contained}");
}

fn get_sections(line: &str) -> (Section, Section) {
    let mut section1 = Section(0, 0);
    let mut section2 = Section(0, 0);

    let section_str_list: Vec<&str> = line.split("-").collect();
    section1.0 = section_str_list[0].parse().unwrap();

    let middle: Vec<&str> = section_str_list[1].split(",").collect();
    section1.1 = middle[0].parse().unwrap();
    section2.0 = middle[1].parse().unwrap();

    section2.1 = section_str_list[2].parse().unwrap();

    (section1, section2)
}

fn is_fully_contained(section1: &Section, section2: &Section) -> bool {
    (section1.0 <= section2.0 && section1.1 >= section2.1)
        || (section2.0 <= section1.0 && section2.1 >= section1.1)
}

fn day4_2(content: &str) {
    let mut overlaps = 0;
    for line in content.lines() {
        let (section1, section2) = get_sections(line);
        if does_overlaps(&section1, &section2) {
            overlaps += 1;
        }
    }

    println!("The number of overlaping sections is {overlaps}");
}

fn does_overlaps(section1: &Section, section2: &Section) -> bool {
    section1.0 <= section2.1 && section1.1 >= section2.0
}
