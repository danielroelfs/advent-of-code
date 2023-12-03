import os
import re

input = open(os.path.join("2023", "day_03", "input_day03.txt"), "r").read().splitlines()

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
