import os

input = open(os.path.join("2025", "day_05", "input_day05.txt")).read()

def part1(input):
    ing_ranges, ingr_ids = input.split("\n\n")

    ing_ranges = [[int(y) for y in x.split("-")] for x in ing_ranges.splitlines()]

    ingr_ids = [int(x) for x in ingr_ids.splitlines()]

    fresh_ings = len(
        set([x for x in ingr_ids for y in ing_ranges if (x >= y[0]) & (x <= y[1])])
    )

    return fresh_ings


print(part1(input))
