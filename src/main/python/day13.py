import time
from functools import cmp_to_key


def is_divider(a):
    """
    Determines whether the given input is a divider element in a nested list.

    Args:
        a (list): The input to check.

    Returns:
        bool: True if the input is a divider element, False otherwise.
    """

    return a == [[2]] or a == [[6]]


def compare(a, b):
    """
    Compares two nested lists and returns 1 if a is greater than b, -1 if a is
    less than b, and 0 if a is equal to b.

    Args:
        a (list): The first list to compare.
        b (list): The second list to compare.

    Returns:
        int: 1 if a is greater than b, -1 if a is less than b, and 0 if a is equal to b.
    """

    if len(a) == 0 and len(b) == 0:
        return 0

    if len(a) == 0:
        return -1

    if len(b) == 0:
        return 1

    if isinstance(a[0], int) and isinstance(b[0], int):
        if a[0] < b[0]:
            return -1
        if a[0] > b[0]:
            return 1
        else:
            return compare(a[1:], b[1:])

    elif isinstance(a[0], list) and isinstance(b[0], list):
        if len(a[0]) == 0 and len(b[0]) != 0:
            return -1

        elif len(a[0]) == 0 and len(b[0]) == 0:
            return compare(a[1:], b[1:])

        elif len(b[0]) == 0:
            return 1

        else:
            inside = compare(a[0], b[0])

            if inside == 0:
                return compare(a[1:], b[1:])

            return inside

    else:
        element1 = a[0]
        element2 = b[0]

        if isinstance(element1, int):
            element1 = [element1]
        else:
            element2 = [element2]

        inside = compare(element1, element2)

        if inside == 0:
            return compare(a[1:], b[1:])

        return inside


def part1(path):
    sum_ = 0
    current_pair = 1

    with open(path, "r") as f:
        last_line = ""
        for line in f:
            if line == "\n":
                current_pair += 1

            elif last_line == "":
                last_line = eval(line.strip())

            else:
                if compare(last_line, eval(line.strip())) == -1:
                    sum_ += current_pair
                last_line = ""

    print(sum_)


def treat_input_part2(path):

    lines = []

    with open(path, "r") as f:
        last_line = ""
        for line in f:
            if line != "\n":
                lines.append(eval(line.strip()))

    return lines


def find_decoder_key(list_):
    """
    Finds the decoder key for a given list of numbers.

    The decoder key is calculated by appending two new sublists to the given list,
    sorting the list using the `compare` function as the key, and then multiplying
    the counter variable by the key variable for each divider element in the list.

    Parameters:
        list_ (list): The list of numbers to process.

    Returns:
        int: The calculated decoder key.
    """

    list_.append([[2]])
    list_.append([[6]])
    list_.sort(key=cmp_to_key(compare))

    key = 1

    for i, a in enumerate(list_):
        if is_divider(a):
            key *= i + 1

    print(key)


if __name__ == "__main__":

    st = time.time()

    path = "resources/day13.txt"

    print("----------------- Day 13 -----------------")
    print("")

    print("Part 1")
    print("")

    part1(path)

    print("")

    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")

    print("Part 2")
    print("")
    find_decoder_key(treat_input_part2(path))
    print("")

    st = et
    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")
