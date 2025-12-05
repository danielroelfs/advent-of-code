import os

input = open(os.path.join("2025", "day_05", "input_day05.txt")).read()

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
