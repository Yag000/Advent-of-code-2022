import time
from functools import cmp_to_key


def is_divider(a):
    return a == [[2]] or a == [[6]]


def compare(a, b):
    if len(a) == 0 and len(b) == 0:
        return 0

    if len(a) == 0:
        return 1

    if len(b) == 0:
        return -1

    if isinstance(a[0], int) and isinstance(b[0], int):
        if a[0] < b[0]:
            return 1
        if a[0] > b[0]:
            return -1
        else:
            return compare(a[1:], b[1:])

    elif isinstance(a[0], list) and isinstance(b[0], list):
        if len(a[0]) == 0 and len(b[0]) != 0:
            return 1

        elif len(a[0]) == 0 and len(b[0]) == 0:
            return compare(a[1:], b[1:])

        elif len(b[0]) == 0:
            return -1

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


def treat_input_part1(path):
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
                if compare(last_line, eval(line.strip())) == 1:
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

    list_.append([[2]])
    list_.append([[6]])
    list_.sort(key=cmp_to_key(compare), reverse=True)

    key = 1
    counter = 1
    for a in list_:
        if is_divider(a):
            key *= counter
        counter += 1

    print(key)


if __name__ == "__main__":

    st = time.time()

    path = "resources/day13.txt"

    print("----------------- Day 13 -----------------")
    print("")

    print("Part 1")
    print("")

    treat_input_part1(path)

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
