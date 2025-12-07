import os
import math

input = open(os.path.join("2025", "day_06", "input_day06.txt")).read().splitlines()

def part2(input):

    rev_values = [x[::-1] for x in input]

    grand_total = 0
    transposed_values = []
    for x in zip(*rev_values):
        try:
            transposed_values = transposed_values + [int("".join(x[:-1]))]
        except ValueError:
            continue
        if x[-1] == "+":
            grand_total += sum(transposed_values)
            transposed_values = []
        elif x[-1] == "*":
            grand_total += math.prod(transposed_values)
            transposed_values = []

    return grand_total


print(part2(input))
