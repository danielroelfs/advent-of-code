### ADVENT OF CODE - DAY 3 ########################

# -- Libraries -------------------------

import os
import re

# -- Load data ------------------------

input = open(os.path.join("2023", "day_03", "input_day03.txt"), "r").read().splitlines()

# -- Part 1 ------------------------

# What is the sum of all of the part numbers in the engine schematic?


def part1(input):
    padding = "." * len(input[0])
    padded = [padding] + input
    parts = []

    for i in range(len(input)):
        for match in re.finditer(r"\d+", input[i]):
            start, end = match.span()
            start, end = max(start - 1, 0), min(end + 1, len(input[i]))
            region = "".join([row[start:end] for row in padded[i : i + 3]])
            if re.search(r"[^.0-9]", region):
                parts.append(int(match.group(0)))

    return sum(parts)


print(part1(input))

# -- Part 2 ------------------------

# What is the sum of all of the gear ratios in your engine schematic?


def part2(input):
    padding = "." * len(input[0])
    padded = [padding] + input
    gear_ratios = []

    for i in range(len(input)):
        for gear in re.finditer(r"\*", input[i]):
            numbers = []
            for row in padded[i : i + 3]:
                for n in re.finditer(r"\d+", row):
                    lower, upper = n.span()
                    if lower - 1 <= gear.start() <= upper:
                        numbers.append(int(n.group(0)))
            if len(numbers) == 2:
                gear_ratios.append(numbers[0] * numbers[1])

    return sum(gear_ratios)


print(part2(input))
