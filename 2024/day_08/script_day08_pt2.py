import os

input = open(os.path.join("2024", "day_08", "input_day08.txt")).read().splitlines()
input = [list(line) for line in input]

def get_pair_antinodes_pt2(antinodes, n, m, x_i, y_i, x_j, y_j):
    dx = x_j - x_i
    dy = y_j - y_i
    multiplier = 0
    while (
        x_i - multiplier * dx >= 0
        and y_i - multiplier * dy >= 0
        and y_i - multiplier * dy < m
    ):
        antinodes_new = antinodes.add((x_i - multiplier * dx, y_i - multiplier * dy))
        multiplier += 1
    multiplier = 0
    while (
        x_j + multiplier * dx < n
        and y_j + multiplier * dy < m
        and y_j + multiplier * dy >= 0
    ):
        antinodes_new = antinodes.add((x_j + multiplier * dx, y_j + multiplier * dy))
        multiplier += 1

    return antinodes_new


def part2(input):
    n = len(input)
    m = len(input[0])
    antinodes = set()

    antenna_locations = {}
    for i in range(n):
        for j in range(m):
            if input[i][j] != ".":
                c = input[i][j]
                antenna_locations[c] = antenna_locations.get(c, []) + [(i, j)]
    for freq, antenna in antenna_locations.items():
        if len(antenna) < 2:
            continue
        for i in range(len(antenna) - 1):
            for j in range(i + 1, len(antenna)):
                x_i, y_i = antenna[i]
                x_j, y_j = antenna[j]
                get_pair_antinodes_pt2(antinodes, n, m, x_i, y_i, x_j, y_j)
    return len(antinodes)


print(part2(input))
