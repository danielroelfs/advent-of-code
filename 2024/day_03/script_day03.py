### ADVENT OF CODE - DAY 3 ########################

# -- Libraries -------------------------

import os
import re
import math

# -- Load data ------------------------

input = open(os.path.join("2024", "day_03", "input_day03.txt")).read()


def get_multiplications(input):
    mul_strings = re.findall(r"mul\(\d+,\d+\)", input)
    mul_vals = [[int(s) for s in re.findall(r"\d+", mul)] for mul in mul_strings]
    mults = [math.prod(x) for x in mul_vals]
    mult_sum = sum(mults)
    return mult_sum


# -- Part 1 ------------------------

# What do you get if you add up all of the results of the multiplications?


def part1(input):
    mult_sum = get_multiplications(input)
    return mult_sum


print(part1(input))

# -- Part 2 ------------------------

# What do you get if you add up all of the results of just the enabled multiplications?


def part2(input):
    input_cleaned = " ".join(sec.split("don't()")[0] for sec in input.split("do()"))
    mult_sum = get_multiplications(input_cleaned)
    return mult_sum


print(part2(input))
