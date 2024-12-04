### ADVENT OF CODE - DAY 4 ########################

# -- Libraries -------------------------

import os
import re


# -- Load data ------------------------

input = open(os.path.join("2024", "day_04", "input_day04.txt")).read()
input = input.split("\n")


def match(matrix, pattern, width):
    matches = 0
    for i in range(len(matrix) - width + 1):
        for j in range(len(matrix[i]) - width + 1):
            block = "".join(matrix[i + x][j : j + width] for x in range(width))
            matches += bool(re.match(pattern, block))

    return matches


# -- Part 1 ------------------------

# How many times does XMAS appear?


def part1(input):
    word_n = 0
    for rotation in range(4):
        word_n += sum(row.count("XMAS") for row in input)
        word_n += match(input, r"X.{4}M.{4}A.{4}S", 4)

        input = ["".join(row[::-1]) for row in zip(*input)]

    return word_n


print(part1(input))


# -- Part 2 ------------------------

# How many times does an X-MAS appear?


def part2(input):
    word_n = 0
    for rotation in range(4):
        word_n += match(input, r"M.M.A.S.S", 3)

        input = ["".join(row[::-1]) for row in zip(*input)]

    return word_n


print(part2(input))
