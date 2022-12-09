import math


class Rope:

    def __init__(self, size):
        self.size = size
        self.nodes = [[0, 0] for _ in range(size)]
        self.tiles_visited = set()

    def compute_distance(self, pos1, pos2):
        return math.sqrt(abs(self.nodes[pos1][0] - self.nodes[pos2][0])**2 + abs(self.nodes[pos1][1] - self.nodes[pos2][1])**2)

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
            old_positions = self.copy_of_nodes()
            self.move_head(direction)

            for i in range(1, self.size):
                if self.compute_distance(i - 1, i) >= 2:
                    self.move_node(i, old_positions)

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

    print(rope.nodes[0][0], rope.nodes[0][1])
    print(rope.nodes[-1][0], rope.nodes[-1][1])
    return len(rope.tiles_visited)


def main():
    input_value = treat_input('resources/day9_input.txt', 2)
    print(input_value)


if __name__ == "__main__":
    main()
