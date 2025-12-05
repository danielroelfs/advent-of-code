### ADVENT OF CODE - DAY 5 ########################

# -- Libraries -------------------------

import os

# -- Load data ------------------------

input = open(os.path.join("2025", "day_05", "input_day05.txt")).read()

# -- Part 1 ------------------------

# Process the database file from the new inventory management system. How many of the available ingredient IDs are fresh?


def part1(input):
    ing_ranges, ingr_ids = input.split("\n\n")

    ing_ranges = [[int(y) for y in x.split("-")] for x in ing_ranges.splitlines()]

    ingr_ids = [int(x) for x in ingr_ids.splitlines()]

    fresh_ings = len(
        set([x for x in ingr_ids for y in ing_ranges if (x >= y[0]) & (x <= y[1])])
    )

    return fresh_ings


print(part1(input))

# -- Part 2 ------------------------

# Process the database file again. How many ingredient IDs are considered to be fresh according to the fresh ingredient ID ranges?


def part2(input):
    ing_ranges = input.split("\n\n")[0]
    ing_ranges = sorted(
        [[int(y) for y in x.split("-")] for x in ing_ranges.splitlines()]
    )

    fresh_ing_ids = []
    for a, b in ing_ranges:
        if not fresh_ing_ids or (fresh_ing_ids[-1][1] < a - 1):
            fresh_ing_ids = fresh_ing_ids + [[a, b]]
        else:
            fresh_ing_ids[-1][1] = max(fresh_ing_ids[-1][1], b)

    num_fresh_ings_ids = sum(b - a + 1 for a, b in fresh_ing_ids)

    return num_fresh_ings_ids


print(part2(input))
