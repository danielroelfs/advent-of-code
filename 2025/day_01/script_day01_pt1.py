import os
import numpy as np

input = open(os.path.join("2025", "day_01", "input_day01.txt")).read().splitlines()

def part1(input):
    input = [x.replace("L", "-") if "L" in x else x.replace("R", "+") for x in input]

    rotations = 50 + np.cumsum([int(x) for x in input])

    dial_number = [
        x - (int(x / 100) * 100) if (np.abs(x) > 99) else x for x in rotations
    ]

    n_zero = int(sum([x + 1 for x in dial_number if x == 0]))

    return n_zero


print(part1(input))
