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

    return board


def drop_sand(x, y, board):
    """If the sand can fall directly down then it does it. If not, it goes to the left  and then to the right if it can't go to the left.

    Args:
        x (int): x position of the sand
        y (int): y position of the sand
        board (List(List(int))): board of the game

    Returns:
        (int,int): final position of the sand
    """

    if x < 0 or x >= len(board) or y < 0 or y >= len(board[0]):
        return (-1, -1)

    # Check if the sand can fall directly down
    if y + 1 < len(board[0]) and board[x][y + 1] == 0:
        y += 1
    # If not, check if it can go left
    elif x - 1 >= 0 and board[x - 1][y] == 0:
        y += 1
        x -= 1
    # If not, check if it can go right
    elif x + 1 < len(board) and board[x + 1][y] == 0:
        y += 1
        x += 1

    return (x, y)


def simulate(board):

    initial_pos = (500 - len(board) + 1, 0)

    print(initial_pos)

    is_falling = True
    counter = 0

    while is_falling:
        is_sand_falling = True
        pos = initial_pos

        last_pos = (0, 0)

        while is_sand_falling:
            new_pos = drop_sand(pos[0], pos[1], board)
            if new_pos == (-1, -1):
                is_falling = False
                break
            if last_pos == new_pos:
                is_sand_falling = False
                board[last_pos[1]][last_pos[0]] = 2
                counter += 1
            last_pos = pos
            pos = new_pos

    return counter


def treat_input(path):
    obstacles = []

    with open(path, "r") as f:
        for line in f:
            line = line.strip().split("->")
            obstacles.append([eval(x) for x in line])

    return obstacles


if __name__ == "__main__":
    print(simulate(init_board(treat_input("resources/day14.txt"))))
