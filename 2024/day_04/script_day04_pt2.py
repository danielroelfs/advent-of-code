import os
import re

input = open(os.path.join("2024", "day_04", "input_day04.txt")).read()
input = input.split("\n")

def match(matrix, pattern, width):
    matches = 0
    for i in range(len(matrix) - width + 1):
        for j in range(len(matrix[i]) - width + 1):
            block = "".join(matrix[i + x][j : j + width] for x in range(width))
            matches += bool(re.match(pattern, block))

    return matches

def part2(input):
    word_n = 0
    for rotation in range(4):
        word_n += match(input, r"M.M.A.S.S", 3)

        input = ["".join(row[::-1]) for row in zip(*input)]

    return word_n


print(part2(input))
