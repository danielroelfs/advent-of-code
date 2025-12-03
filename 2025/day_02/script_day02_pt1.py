import os

input = open(os.path.join("2025", "day_02", "input_day02.txt")).read().split(",")

def part1(input):
    id_ranges = [[int(x) for x in strings.split("-")] for strings in input]

    valid_ids = []
    for min_val, max_val in id_ranges:
        values_in_range = [str(x) for x in list(range(min_val, max_val + 1))]
        valid_ids = valid_ids + [
            x for x in values_in_range if x[: int(len(x) / 2)] == x[int(len(x) / 2) :]
        ]

    sum_of_valid = sum([int(x) for x in valid_ids])

    return sum_of_valid


print(part1(input))
