### ADVENT OF CODE - DAY 6 ########################

# -- Libraries -------------------------

import os
import math

# -- Load data ------------------------

input = open(os.path.join("2025", "day_06", "input_day06.txt")).read().splitlines()

# -- Part 1 ------------------------

# What is the grand total found by adding together all of the answers to the individual problems?


def part1(input):
    values = [[int(y) for y in x.split(" ") if len(y) > 0] for x in input[:-1]]
    operators = [x for x in input[-1].split(" ") if len(x) > 0]

    assert len(operators) == len(values[0])

    answers = []
    for i in range(len(values[0])):
        values_of_interest = [values[i] for values in values]
        answers = answers + [
            (
                sum(values_of_interest)
                if operators[i] == "+"
                else math.prod(values_of_interest)
            )
        ]

    grand_total = sum(answers)

    return grand_total


print(part1(input))

# -- Part 2 ------------------------

# What is the grand total found by adding together all of the answers to the individual problems?


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
