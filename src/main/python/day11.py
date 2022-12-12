import time


class Monkey:
    """
    A class representing a monkey.
    """

    def __str__(self):
        """
        Return a string representation of the monkey.
        """

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

        """
        Initialize a monkey with the given characteristics.

        :param id_: The ID number of the monkey.
        :param items: A list of items that the monkey has.
        :param operator: The operator to use for operations with the items.
        :param number_operation: The number to use for operations with the items.
        :param test_number: The test number used to determine where to send the items.
        :param where_if_true: The destination for the items if the test is true.
        :param where_if_false: The destination for the items if the test is false.
        """

        self.id = id_
        self.items = items
        self.operator = operator
        self.number_operation = number_operation
        self.test_number = test_number
        self.where_if_true = where_if_true
        self.where_if_false = where_if_false
        self.number_inspections = 0

    def update(self, monkey_list, lcm=1, day1=True):
        """
        Update the items of the monkey according to the given parameters.

        :param monkey_list: A list of all the monkeys.
        :param lcm: The least common multiple to use for the update.
        :param day1: A flag indicating whether this is the first day of the update.
        """

        for item in self.items:
            self.number_inspections += 1

            value = (
                item if self.number_operation == "old" else int(self.number_operation)
            )

            if self.operator == "+":
                item = item + value
            else:
                item = item * value

            if day1:
                item = int(item / 3)
            else:
                item = item % lcm

            if item % self.test_number == 0:
                monkey_list[self.where_if_true].items.append(item)
            else:
                monkey_list[self.where_if_false].items.append(item)

        self.items = []

    def update_value(self, line, index):
        """
        Update the value of a characteristic of the monkey based on the given line and index.

        :param line: The line containing the new value for the characteristic.
        :param index: The index of the characteristic to update.
        """

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


def play_round(monkey_list, lcm=1, day1=True):
    """
    Play a round of the game with the given monkey list.

    :param monkey_list: A list of the monkeys in the game.
    :param lcm: The least common multiple to use for the update.
    :param day1: A flag indicating whether this is the first day of the update.
    """

    for monkey in monkey_list:
        monkey.update(monkey_list, lcm, day1)


def play_rounds(monkey_list, n, lcm=1, day1=True):
    """
    Play the given number of rounds of the game with the given monkey list.

    :param monkey_list: A list of the monkeys in the game.
    :param n: The number of rounds to play.
    :param lcm: The least common multiple to use for the update.
    :param day1: A flag indicating whether this is the first day of the update.
    """

    for _ in range(n):
        play_round(monkey_list, lcm, day1)


def get_monkey_list(path):
    """
    Get the list of monkeys from the file at the given path.

    :param path: The path to the file containing the monkey data.
    :return: A list of the monkeys in the game.
    """

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

    return monkeys


def main1(path):
    """
    Play the first part of the game with the monkeys in the file at the given path.

    :param path: The path to the file containing the monkey data.
    :return: The result of the first part of the game.
    """

    monkeys = get_monkey_list(path)

    play_rounds(monkeys, 20)

    values = [monkey.number_inspections for monkey in monkeys]

    sorted_list = sorted(values, reverse=True)

    biggest_two = sorted_list[:2]

    return biggest_two[0] * biggest_two[1]


def main2(path):
    """
    Play the second part of the game with the monkeys in the file at the given path.

    :param path: The path to the file containing the monkey data.
    :return: The result of the second part of the game.
    """

    monkeys = get_monkey_list(path)

    lcm = 1

    for monkey in monkeys:
        lcm *= monkey.test_number

    play_rounds(monkeys, 10000, lcm, False)

    values = [monkey.number_inspections for monkey in monkeys]

    sorted_list = sorted(values, reverse=True)

    biggest_two = sorted_list[:2]

    return biggest_two[0] * biggest_two[1]


if __name__ == "__main__":

    st = time.time()

    print("----------------- Day 11 -----------------")
    print("")

    print("Part 1")
    print("")
    print(main1("resources/day11.txt"))
    print("")

    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")

    print("Part 2")
    print("")
    print(main2("resources/day11.txt"))
    print("")

    st = et
    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")
