import math


def compute_visible_trees_from_position(trees, i, j):
    """
    This function takes in a 2D list of integers called trees and two integers i and j,
    and returns the number of trees visible from the position (i,j) in the trees grid.

    Args:
    trees (list): A 2D list of integers representing the heights of trees in a grid
    i (int): The row index of the position from which the trees are being counted
    j (int): The column index of the position from which the trees are being counted

    Returns:
    int: The number of trees visible from the position (i,j) in the trees grid
    """

    height = trees[i][j]
    counter = []

    count = 0
    for x in range(i + 1, len(trees)):
        count += 1
        if trees[x][j] >= height:
            break

    counter.append(count)
    count = 0

    for x in range(i - 1, -1, -1):
        count += 1
        if trees[x][j] >= height:
            break

    counter.append(count)
    count = 0

    for y in range(j + 1, len(trees[i])):
        count += 1
        if trees[i][y] >= height:
            break

    counter.append(count)
    count = 0

    for y in range(j - 1, -1, -1):
        count += 1
        if trees[i][y] >= height:
            break

    counter.append(count)

    return math.prod(counter)


def is_visible(trees, i, j):
    """
    This function checks if the tree at position (i, j) in the given "trees" grid
    is visible from the outside of the grid.

    Args:
    - trees: a 2D list of integers representing the heights of trees in a grid
    - i: the row index of the tree to check
    - j: the column index of the tree to check

    Returns:
    - a boolean indicating whether the tree is visible or not
    """

    if i == 0 or j == 0 or i == len(trees) - 1 or j == len(trees[0]) - 1:
        return True

    flag = True

    for k in range(i):
        if trees[k][j] >= trees[i][j]:
            flag = False
            break
    if flag:
        return True
    flag = True

    for k in range(i + 1, len(trees[0])):
        if trees[k][j] >= trees[i][j]:
            flag = False
            break
    if flag:
        return True
    flag = True

    for k in range(j):
        if trees[i][k] >= trees[i][j]:
            flag = False
            break
    if flag:
        return True
    flag = True

    for k in range(j + 1, len(trees[0])):
        if trees[i][k] >= trees[i][j]:
            flag = False
            break

    return flag


def compute_visible(trees):
    """
    This function computes the number of trees in the given "trees" grid that are
    visible from the outside of the grid.

    Args:
    - trees: a 2D list of integers representing the heights of trees in a grid

    Returns:
    - the number of visible trees in the grid
    """

    counter = 0

    for i in range(len(trees)):
        for j in range(len(trees[0])):
            if is_visible(trees, i, j):
                counter += 1

    return counter


def compute_best_vision(trees):
    """
    This function computes the maximum number of trees that are visible from a single position
    in the given "trees" grid.

    Args:
    - trees: a 2D list of integers representing the heights of trees in a grid

    Returns:
    - the maximum number of visible trees from a single position in the grid
    """

    counter = 0

    for i in range(len(trees)):
        for j in range(len(trees[0])):
            new_value = compute_visible_trees_from_position(trees, i, j)
            if new_value > counter:
                counter = new_value

    return counter


def treat_input(path):
    """
    This function reads the input file at the given "path" and parses it into a
    2D list of integers representing the heights of trees in a grid.

    Args:
    - path: the path to the input file

    Returns:
    - a 2D list of integers representing the heights of trees in a grid
    """

    array_of_trees = []

    with open(path, "r") as f:
        last_char = ""
        for line in f:

            array_of_trees.append([int(x) for x in line[:-1]])
            last_char = line[-1]

    array_of_trees[-1].append(int(last_char))

    return array_of_trees


def main():
    """
    This is the main entry point of the program. It reads the input from a file,
    computes the number of visible trees in the grid, and the maximum number of
    trees that are visible from a single position in the grid. It then prints
    the results to the console.
    """

    input_value = treat_input("resources/day8_input.txt")
    print(compute_visible(input_value))
    print(compute_best_vision(input_value))


if __name__ == "__main__":
    main()
