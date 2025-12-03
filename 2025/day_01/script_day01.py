### ADVENT OF CODE - DAY 1 ########################

# -- Libraries -------------------------

import os
import numpy as np

# -- Load data ------------------------

input = open(os.path.join("2025", "day_01", "input_day01.txt")).read().splitlines()

# -- Part 1 ------------------------

# The actual password is the number of times the dial is left pointing at 0 after any rotation in the sequence.


def part1(input):
    input = [x.replace("L", "-") if "L" in x else x.replace("R", "+") for x in input]

    rotations = 50 + np.cumsum([int(x) for x in input])

    dial_number = [
        x - (int(x / 100) * 100) if (np.abs(x) > 99) else x for x in rotations
    ]

    n_zero = int(sum([x + 1 for x in dial_number if x == 0]))

    return n_zero


print(part1(input))


# -- Part 2 ------------------------

# Using password method 0x434C49434B, what is the password to open the door?


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
