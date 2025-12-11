### ADVENT OF CODE - DAY 5 ########################

# -- Libraries -------------------------

import os

# -- Load data ------------------------

input = open(os.path.join("2025", "day_04", "input_day04.txt")).read().splitlines()
input = [list(x) for x in input]

# -- Part 1 ------------------------

# How many rolls of paper can be accessed by a forklift?


def get_neighbors(coordinates_of_interest, diagram):
    x, y = coordinates_of_interest
    neighbors = []
    if x < len(diagram[0]) - 1:
        neighbors.append(diagram[y][x + 1])
    if x > 0:
        neighbors.append(diagram[y][x - 1])
    if y < len(diagram) - 1:
        neighbors.append(diagram[y + 1][x])
    if y > 0:
        neighbors.append(diagram[y - 1][x])
    if x < len(diagram[0]) - 1 and y > 0:
        neighbors.append(diagram[y - 1][x + 1])
    if x > 0 and y > 0:
        neighbors.append(diagram[y - 1][x - 1])
    if x < len(diagram[0]) - 1 and y < len(diagram) - 1:
        neighbors.append(diagram[y + 1][x + 1])
    if x > 0 and y < len(diagram) - 1:
        neighbors.append(diagram[y + 1][x - 1])

    n_rolls_inaccessible = len([x for x in neighbors if x == "@"])

    return n_rolls_inaccessible


def part1(input):
    solution = 0
    for y in range(len(input)):
        for x in range(len(input[0])):
            if (input[y][x] == "@") & (get_neighbors([x, y], input) < 4):
                solution += 1

    return solution


print(part1(input))

# -- Part 2 ------------------------

# How many rolls of paper in total can be removed by the Elves and their forklifts?
