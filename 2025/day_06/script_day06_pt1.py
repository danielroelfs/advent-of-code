import os
import math

input = open(os.path.join("2025", "day_06", "input_day06.txt")).read().splitlines()

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
