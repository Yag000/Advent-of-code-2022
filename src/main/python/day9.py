import time


class Rope:
    """
    Class representing a Rope, which is made up of a number of nodes.

    Attributes:
    - size (int): the number of nodes in the rope
    - nodes (List[List[int]]): the coordinates of each node in the rope
    - tiles_visited (Set[Tuple[int,int]]): the coordinates of tiles visited by the rope
    """

    def __init__(self, size):
        """
        Initializes a new Rope object with the given number of nodes.

        :param size: the number of nodes in the rope
        """

        self.size = size
        self.nodes = [[0, 0] for _ in range(size)]
        self.tiles_visited = set()

    def compute_next_position(self, i):
        """
        Computes the next position for the node at the given index.

        :param i: the index of the node to compute the next position for
        :return: the next position for the node
        """

        dx = self.nodes[i - 1][0] - self.nodes[i][0]
        dy = self.nodes[i - 1][1] - self.nodes[i][1]

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
        """
        Updates the position of the node at the given index.

        :param i: the index of the node to update
        """
        dx, dy = self.compute_next_position(i)
        self.nodes[i][0] += dx
        self.nodes[i][1] += dy

    def move_head(self, direction):
        """
        Moves the head of the rope in the given direction.

        :param direction: the direction to move the head in (U, D, L, or R)
        """

        if direction == "U":
            self.nodes[0][1] += 1
        elif direction == "D":
            self.nodes[0][1] -= 1
        elif direction == "R":
            self.nodes[0][0] += 1
        else:
            self.nodes[0][0] -= 1

    def move(self, direction, steps):
        """Move the rope in the specified direction for the given number of steps.

        Args:
            direction (str): The direction to move in (N, E, S, or W).
            steps (int): The number of steps to take in the given direction.
        """

        for _ in range(steps):
            self.move_head(direction)

            for i in range(1, self.size):
                self.update_position(i)

            self.tiles_visited.add((self.nodes[-1][0], self.nodes[-1][1]))


def treat_input(path, size):
    """Process the input file and return the number of tiles visited by the rope.

    Args:
        path (str): The path to the input file.
        size (int): The size of the rope.

    Returns:
        int: The number of tiles visited by the rope.
    """

    rope = Rope(size)

    with open(path, "r") as f:
        for line in f:
            rope.move(line[0], int(line[2:]))

    return len(rope.tiles_visited)


def main():
    """Process the input file and print the number of tiles visited by the rope."""

    st = time.time()

    print("----------------- Day 9 -----------------")
    print("")

    print("Part 1")
    print("")
    print(treat_input("resources/day9.txt", 2))
    print("")

    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")
    print("")

    print("Part 2")
    print("")
    print(treat_input("resources/day9.txt", 10))
    print("")

    st = et
    et = time.time()
    elapsed_time = et - st
    print("Time:", elapsed_time, "s")


if __name__ == "__main__":
    main()
