def get_sizes(board):
    x_min = min([min(x, key=lambda z: z[0])[0] for x in board])
    x_max = max([max(x, key=lambda z: z[0])[0] for x in board])
    y_max = max([max(y, key=lambda z: z[1])[1] for y in board])

    return x_min, x_max, y_max


def init_board(obstacles):
    x_min, x_max, y_max = get_sizes(obstacles)
    board = [[0 for _ in range(y_max + 1)] for _ in range(x_max - x_min + 1)]
    for obstacle in obstacles:
        for i in range(len(obstacle) - 1):
            is_y = obstacle[i][0] == obstacle[i + 1][0]

            for variation in range(
                abs(obstacle[i][1] - obstacle[i + 1][1])
                if is_y
                else abs(obstacle[i][0] - obstacle[i + 1][0])
            ):
                if is_y:
                    board[obstacle[i][0] - x_min][
                        min(obstacle[i][1], obstacle[i + 1][1]) + variation
                    ] = 1
                else:
                    board[min(obstacle[i][0], obstacle[i + 1][0]) + variation - x_min][
                        obstacle[i][1]
                    ] = 1

    return x_max, board


def drop_sand(x, y, board):
    """If the sand can fall directly down then it does it. If not, it goes to the left  and then to the right if it can't go to the left.

    Args:
        x (int): x position of the sand
        y (int): y position of the sand
        board (List(List(int))): board of the game

    Returns:
        (int,int): final position of the sand
    """

    if x < 0 or x >= len(board):
        return False

    if y >= len(board[0]) - 1:
        return True

    new_pos = [x, y]

    # Check if the sand can fall directly down
    if y + 1 < len(board[0]) and board[x][y + 1] == 0:
        new_pos[1] += 1
    # If not, check if it can go left
    elif x - 1 >= 0 and board[x - 1][y] == 0:
        new_pos[1] += 1
        new_pos[0] -= 1
    # If not, check if it can go right
    elif x + 1 < len(board) and board[x + 1][y] == 0:
        new_pos[1] += 1
        new_pos[0] += 1

    if new_pos == [x, y]:
        return True

    board[x][y] = 0
    board[new_pos[0]][new_pos[1]] = 2

    return drop_sand(new_pos[0], new_pos[1], board)


def simulate(x_max, board):

    initial_pos = (x_max - 500, 0)

    is_falling = True
    counter = 0

    while is_falling:
        pos = initial_pos

        is_falling = drop_sand(pos[0], pos[1], board)
        counter += 1

    return counter


def treat_input(path):
    obstacles = []

    with open(path, "r") as f:
        for line in f:
            line = line.strip().split("->")
            obstacles.append([eval(x) for x in line])

    return obstacles


def print_board(board):

    for i in board:
        for j in i:
            if j == 0:
                print(" ", end="")
            if j == 1:
                print("#", end="")
            else:
                print("o", end="")
        print("\n", end="")


if __name__ == "__main__":

    x_max, board = init_board(treat_input("resources/day14.txt"))
    print_board(board)
    # print(simulate(x_max, board))
