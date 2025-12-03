import os

input = open(os.path.join("2025", "day_03", "input_day03.txt")).read().splitlines()

def part1(input):
    total_joltage = 0
    for bank in input:
        list_of_digits = [int(x) for x in bank]

        max_joltage = 0
        for i in range(len(list_of_digits)):
            for j in range(i + 1, len(list_of_digits)):
                max_joltage = max(
                    max_joltage, 10 * list_of_digits[i] + list_of_digits[j]
                )

        total_joltage += max_joltage

    return total_joltage


print(part1(input))
