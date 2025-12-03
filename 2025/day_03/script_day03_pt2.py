import os

input = open(os.path.join("2025", "day_03", "input_day03.txt")).read().splitlines()

def part2(input):
    total_joltage = 0
    for bank in input:
        list_of_digits = [int(x) for x in bank]

        joltage = [[0 for _ in range(12 + 1)] for _ in range(len(list_of_digits) + 1)]

        for i in range(len(list_of_digits)):
            for j in range(12 + 1):
                joltage[i + 1][j] = max(joltage[i + 1][j], joltage[i][j])
                if j < 12:
                    joltage[i + 1][j + 1] = max(
                        joltage[i + 1][j + 1], 10 * joltage[i][j] + list_of_digits[i]
                    )

            total_joltage += joltage[len(list_of_digits)][12]

    return total_joltage


print(part2(input))
