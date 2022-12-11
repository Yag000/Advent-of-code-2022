class Monkey:
    def __str__(self):

        return f"Monkey {self.id}: {self.items}, {self.number_inspections} inspections, {self.operator} {self.number_operation}, {self.test_number}, {self.where_if_true}, {self.where_if_false}"

    def __init__(
        self,
        id_,
        items,
        operator,
        number_operation,
        test_number,
        where_if_true,
        where_if_false,
    ):
        self.id = id_
        self.items = items
        self.operator = operator
        self.number_operation = number_operation
        self.test_number = test_number
        self.where_if_true = where_if_true
        self.where_if_false = where_if_false
        self.number_inspections = 0

    def update(self, monkey_list):
        for item in self.items:
            self.number_inspections += 1

            value = (
                item if self.number_operation == "old" else int(self.number_operation)
            )

            if self.operator == "+":
                item = item + value
            else:
                item = item * value

            item = int(item / 3)

            if item % self.test_number == 0:
                monkey_list[self.where_if_true].items.append(item)
            else:
                monkey_list[self.where_if_false].items.append(item)

        self.items = []

    def update_value(self, line, index):
        if index == 0:
            self.id = int(line[-2])
        elif index == 1:
            line = line.split(":")
            line = line[1][1:].strip().split(",")
            self.items = list(map(int, line))
        elif index == 2:
            line = line.split()
            self.operator = line[4]
            self.number_operation = line[-1]
        elif index == 3:
            self.test_number = int(line.split()[-1])
        elif index == 4:
            self.where_if_true = int(line.split()[-1])
        elif index == 5:
            self.where_if_false = int(line.split()[-1])


def play_round(monkey_list):
    for monkey in monkey_list:
        monkey.update(monkey_list)


def play_rounds(monkey_list, n):
    for _ in range(n):
        play_round(monkey_list)


def main(path):

    temp_monkey = Monkey(0, [], "", 0, 0, 0, 0)
    monkeys = []
    index = 0
    with open(path, "r") as f:
        for line in f:
            if line == "\n":
                monkeys.append(temp_monkey)
                temp_monkey = Monkey(0, [], "", 0, 0, 0, 0)
                index = 0
            else:
                temp_monkey.update_value(line.strip(), index)
                index += 1

    monkeys.append(temp_monkey)

    for monkey in monkeys:
        print(monkey)

    play_rounds(monkeys, 20)

    values = [monkey.number_inspections for monkey in monkeys]

    # Sort the list in descending order
    sorted_list = sorted(values, reverse=True)

    # Get the first two items from the sorted list
    biggest_two = sorted_list[:2]

    return biggest_two[0] * biggest_two[1]


if __name__ == "__main__":
    print(main("resources/day11.txt"))
