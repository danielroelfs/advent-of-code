### ADVENT OF CODE - DAY 7 ########################

# -- Libraries -------------------------

import os

# -- Load data ------------------------

input = open(os.path.join("2025", "day_07", "input_day07.txt")).read().splitlines()


def process_tachyon_manifold_diagram(input):
    width = len(input[0])
    beams = [0] * width
    beams[input[0].index("S")] = 1

    n_splits = 0
    for manifold_row in input[1:]:
        for manifold_col in range(width):
            if manifold_row[manifold_col] == "^" and beams[manifold_col] > 0:
                beams[manifold_col - 1] += beams[manifold_col]
                beams[manifold_col + 1] += beams[manifold_col]
                n_splits += 1
                beams[manifold_col] = 0

    return n_splits, beams


# -- Part 1 ------------------------

# Analyze your manifold diagram. How many times will the beam be split?


def part1(input):
    n_splits, _ = process_tachyon_manifold_diagram(input)

    return n_splits


print(part1(input))

# -- Part 2 ------------------------

# In total, how many different timelines would a single tachyon particle end up on?


def part2(input):
    _, beams = process_tachyon_manifold_diagram(input)

    n_timelines = sum(beams)

    return n_timelines


print(part2(input))
