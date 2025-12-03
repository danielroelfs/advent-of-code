import os
import numpy as np

input = open(os.path.join("2025", "day_01", "input_day01.txt")).read().splitlines()

def part2(input):
    instruction = [
        int(x.replace("L", "-")) if "L" in x else int(x.replace("R", "+"))
        for x in input
    ]

    dial_number = 50
    n_zero = 0
    for x in instruction:
        if x > 0:
            n_zero += (dial_number + np.abs(x)) // 100
            dial_number = (dial_number + np.abs(x)) % 100
        else:
            if dial_number == 0:
                n_zero += np.abs(x) // 100
            elif np.abs(x) >= dial_number:
                n_zero += (np.abs(x) - dial_number) // 100 + 1
            dial_number = (dial_number - np.abs(x)) % 100

    return int(n_zero)


print(part2(input))
