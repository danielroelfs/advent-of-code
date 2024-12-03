import os
import re
import math

input = open(os.path.join("2024", "day_03", "input_day03.txt")).read()

def get_multiplications(input):
    mul_strings = re.findall(r"mul\(\d+,\d+\)", input)
    mul_vals = [[int(s) for s in re.findall(r"\d+", mul)] for mul in mul_strings]
    mults = [math.prod(x) for x in mul_vals]
    mult_sum = sum(mults)
    return mult_sum

def part1(input):
    mult_sum = get_multiplications(input)
    return mult_sum


print(part1(input))
