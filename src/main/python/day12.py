import time


def get_neighbors(array, x, y):
    """
    Get the immediate neighbors of a given position in a 2D array.

    Args:
        array (List[List[int]]): A 2D list representing the grid.
        x (int): The x-coordinate of the position.
        y (int): The y-coordinate of the position.

    Yields:
        Tuple[int, int]: The x and y coordinates of the neighbor positions.
    """

    for new_x, new_y in (x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1):
        if 0 <= new_x < len(array) and 0 <= new_y < len(array[0]):
            yield (new_x, new_y)


def is_correct_position(pos1, pos2):
    """
    Check if two characters can be considered as neighbors in the grid.

    Args:
        pos1 (str): The first character.
        pos2 (str): The second character.

    Returns:
        bool: True if the characters are considered neighbors, False otherwise.
    """

    if pos2 == "E":
        pos2 = "z"

    if pos1 == "S":
        pos1 = "a"

    return ord(pos2) - ord(pos1) <= 1


def search_path(starting_char, array):
    """
    This function searches for a path in the given `array` starting from the characters specified in `starting_char`.
    The path is searched using a breadth-first search algorithm. The function prints the number of steps required
    to reach the end of the path and returns the set of visited coordinates.

    :param starting_char: a string or a list of strings containing the characters to start the search from
    :param array: a two-dimensional list representing the grid to search in
    :return: a set of tuples containing the coordinates of the visited positions
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
    This function reads the input file located at the given `path` and returns the content as a two-dimensional list.

    :param path: the path to the input file
    :return: a two-dimensional list representing the content of the input file
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
