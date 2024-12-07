### ADVENT OF CODE - DAY 7 ########################

# -- Libraries -------------------------

import os
import re
from functools import reduce
from itertools import product
from operator import add, mul

# -- Load data ------------------------

input = open(os.path.join("2024", "day_07", "input_day07.txt")).read()
input = [list(map(int, re.findall(r"(\d+)", x))) for x in input.splitlines()]


def check_equation(equation, operators):
    test_val, nums = equation[0], equation[1:]
    for ops in product(operators, repeat=(len(nums) - 1)):
        if reduce(lambda k, x: x[0](k, x[1]), zip(ops, nums[1:]), nums[0]) == test_val:
            return True
    return False


# -- Part 1 ------------------------

# Determine which equations could possibly be true. What is their total calibration result?


def part1(input):
    cal_result = sum(eq[0] for eq in input if check_equation(eq, (add, mul)))
    return cal_result


print(part1(input))

# -- Part 2 ------------------------

# What is their total calibration result?


def _concat(a, b):
    a *= 10 ** len(str(b))
    return a + b


def part2(input):
    cal_result = sum(eq[0] for eq in input if check_equation(eq, (add, mul, _concat)))

    return cal_result


print(part2(input))
