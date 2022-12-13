import time


def get_neighbors(array, x, y):
    """
    Returns the neighboring cells of the given cell in the given two-dimensional array.

    The neighbors of a cell are the cells that are adjacent to it horizontally, vertically, or diagonally.

    :param array: A two-dimensional array of cells.
    :param x: The x-coordinate of the cell.
    :param y: The y-coordinate of the cell.
    :return: An iterator yielding the coordinates of the neighboring cells.
    :rtype: Iterator[Tuple[int, int]]
    """

    for new_x, new_y in (x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1):
        if 0 <= new_x < len(array) and 0 <= new_y < len(array[0]):
            yield (new_x, new_y)


def is_correct_position(pos1, pos2):
    """
    Returns whether the second position is adjacent to the first position in the alphabet.

    :param pos1: The first position.
    :param pos2: The second position.
    :return: True if the second position is adjacent to the first position in the alphabet, False otherwise.
    :rtype: bool
    """

    if pos2 == "E":
        pos2 = "z"

    if pos1 == "S":
        pos1 = "a"

    return ord(pos2) - ord(pos1) <= 1


def search_path(starting_char, array):
    """
    Searches for a path from the given starting character to the end character in the given two-dimensional array.

    This function uses a breadth-first search algorithm to find the shortest path from the given starting character
    to the end character, if such a path exists. The function prints the length of the shortest path and returns a set
    of coordinates visited during the search.

    :param starting_char: The starting character.
    :param array: A two-dimensional array of characters.
    :return: A set of coordinates visited during the search.
    :rtype: Set[Tuple[int, int]]
    """
    queue = []
    visited = set()

    for i in range(len(array)):
        for j in range(len(array[0])):
            if array[i][j] in starting_char:
                queue.append((0, i, j))
                visited.add((i, j))

    for times, x, y in queue:
        if array[x][y] == "E":
            print(times)
            break

        for new_x, new_y in get_neighbors(array, x, y):
            if (
                is_correct_position(array[x][y], array[new_x][new_y])
                and (new_x, new_y) not in visited
            ):
                visited.add((new_x, new_y))
                queue.append((times + 1, new_x, new_y))

    return visited


def treat_input(path):
    """
    Reads a file located at the given path and returns its contents as a 2D array of characters.

    Args:
        path (str): The path to the file to read.

    Returns:
        A 2D array of characters representing the contents of the file.
    """

    array = []
    with open(path, "r") as f:
        for line in f:
            array.append([x for x in line.strip()])

    return array


if __name__ == "__main__":

    st = time.time()

    input_value = treat_input("resources/day12.txt")

    print("----------------- Day 12 -----------------")
    print("")

    print("Part 1")
    print("")

    search_path("S", input_value)

    print("")

    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")

    print("Part 2")
    print("")
    search_path(["S", "a"], input_value)
    print("")

    st = et
    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")
