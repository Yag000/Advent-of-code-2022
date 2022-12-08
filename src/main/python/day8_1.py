import math


def compute_visible_trees_from_position(trees, i, j):
    """Returns the amount of visible trees from a given position.

    Args:
        trees (lis[list[int]]): The list of trees
        i (int): Coordinate i
        j (int): Coordinate j
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
    """Checks if a tree is visible

    Args:
        trees (lis[list[int]]): The list of trees
        i (int): Coordinate i
        j (int): Coordinate j
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

    for k in range(i+1, len(trees[0])):
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

    for k in range(j+1, len(trees[0])):
        if trees[i][k] >= trees[i][j]:
            flag = False
            break

    return flag


def compute_visible(trees):

    counter = 0

    for i in range(len(trees)):
        for j in range(len(trees[0])):
            if is_visible(trees, i, j):
                counter += 1

    return counter


def compute_best_vision(trees):
    counter = 0

    for i in range(len(trees)):
        for j in range(len(trees[0])):
            new_value = compute_visible_trees_from_position(trees, i, j)
            if new_value > counter:
                counter = new_value

    return counter


def treat_input(path):
    """Treats the input

    Args:
        path (str): Path to the input file

    Returns:
        list[list[int]]: The list of trees
    """

    array_of_trees = []

    with open(path, 'r') as f:
        last_char = ''
        for line in f:

            array_of_trees.append([int(x) for x in line[:-1]])
            last_char = line[-1]

    array_of_trees[-1].append(int(last_char))

    return array_of_trees


def main():
    input_value = treat_input('resources/day8_input.txt')
    print(compute_visible(input_value))
    print(compute_best_vision(input_value))


if __name__ == "__main__":
    main()
