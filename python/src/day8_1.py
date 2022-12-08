import tabulate


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

    print(tabulate.tabulate(array_of_trees))

    return array_of_trees


def main():
    print(compute_visible(treat_input('resources/day8_input.txt')))


if __name__ == "__main__":
    main()
