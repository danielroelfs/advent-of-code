import os

input = open(os.path.join("2025", "day_02", "input_day02.txt")).read().split(",")

def part2(input):
    id_ranges = [[int(x) for x in strings.split("-")] for strings in input]

    valid_ids = []
    for min, max in id_ranges:
        values_in_range = [str(x) for x in list(range(min, max + 1))]
        valid_ids = valid_ids + [x for x in values_in_range if x in (x * 2)[1:-1]]

    sum_of_valid = sum([int(x) for x in valid_ids])

    return sum_of_valid


print(part2(input))
