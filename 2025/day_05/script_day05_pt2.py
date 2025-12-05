import os

input = open(os.path.join("2025", "day_05", "input_day05.txt")).read()

def part2(input):
    ing_ranges = input.split("\n\n")[0]
    ing_ranges = sorted(
        [[int(y) for y in x.split("-")] for x in ing_ranges.splitlines()]
    )

    fresh_ing_ids = []
    for min_val, max_val in ing_ranges:
        if not fresh_ing_ids or (fresh_ing_ids[-1][1] < min_val - 1):
            fresh_ing_ids = fresh_ing_ids + [[min_val, max_val]]
        else:
            fresh_ing_ids[-1][1] = max(fresh_ing_ids[-1][1], max_val)

    num_fresh_ings_ids = sum(
        max_val - min_val + 1 for min_val, max_val in fresh_ing_ids
    )

    return num_fresh_ings_ids


print(part2(input))
