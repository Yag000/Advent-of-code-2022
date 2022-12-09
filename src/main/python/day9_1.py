import math


class Rope:

    def __init__(self, size):
        self.size = size
        self.nodes = [[0, 0] for _ in range(size)]
        self.tiles_visited = set()

    def compute_distance(self, pos1, pos2):
        return math.sqrt(abs(self.nodes[pos1][0] - self.nodes[pos2][0])**2 + abs(self.nodes[pos1][1] - self.nodes[pos2][1])**2)

    def compute_next_position(self, i):

        dx = self.nodes[i-1][0] - self.nodes[i][0]
        dy = self.nodes[i-1][1] - self.nodes[i][1]

        if abs(dx) < 2 and abs(dy) < 2:
            return (0, 0)

        if dy == 0:
            return (1 if dx > 0 else -1, 0)
        if dx == 0:
            return (0, 1 if dy > 0 else -1)

        # is on the top right corner
        if dx < 0 and dy < 0:
            return (-1, -1)

        # is on the top left corner
        if dx < 0 and dy > 0:
            return (-1, 1)

        # is on the top right corner
        if dx > 0 and dy < 0:
            return (1, -1)

        # is on the top right corner
        if dx > 0 and dy > 0:
            return (1, 1)

        return (dx, dy)

    def update_position(self, i):
        dx, dy = self.compute_next_position(i)
        self.nodes[i][0] += dx
        self.nodes[i][1] += dy

    def move_head(self, direction):
        if direction == 'U':
            self.nodes[0][1] += 1
        elif direction == 'D':
            self.nodes[0][1] -= 1
        elif direction == 'R':
            self.nodes[0][0] += 1
        else:
            self.nodes[0][0] -= 1

    def move_node(self, index, last_positions):
        self.nodes[index][0] = last_positions[index - 1][0]
        self.nodes[index][1] = last_positions[index - 1][1]

    def copy_of_nodes(self):
        new_nodes = []

        for node in self.nodes:
            new_nodes.append((node[0], node[1]))

        return new_nodes

    def move(self, direction, steps):

        for _ in range(steps):
            self.move_head(direction)

            for i in range(1, self.size):
                self.update_position(i)

            self.tiles_visited.add(
                (self.nodes[-1][0], self.nodes[-1][1]))

    def print_rope(self):
        xMax = max([M[0] for M in self.nodes])
        xMin = min([M[0] for M in self.nodes])
        yMin = min([M[1] for M in self.nodes])
        yMax = max([M[1] for M in self.nodes])

        # print(f"({xMin},{yMin}) ; ({xMax}, {yMax})")
        print("-"*10)

        board = []

        def dictIndex(value):
            if (value == 0):
                return "H"
            return str(value)

        for y in range(yMin, yMax + 1, 1):
            line = ""
            for x in range(xMin, xMax + 1, 1):
                if x == 0 and y == 0 and [x, y] in self.nodes:
                    line += "s"
                elif [x, y] in self.nodes:
                    line += dictIndex(self.nodes.index([x, y]))
                else:
                    line += "."
            board.insert(0, line)

        print(*board, sep="\n")


def treat_input(path, size):
    """Treats the input

    Args:
        path (str): Path to the input file

    Returns:
        list[list[int]]: The list of trees
    """

    rope = Rope(size)

    with open(path, 'r') as f:
        for line in f:
            rope.move(line[0], int(line[2:]))

    return len(rope.tiles_visited)


def main():
    input_value = treat_input('resources/day9_input.txt', 10)
    print(input_value)


if __name__ == "__main__":
    main()
