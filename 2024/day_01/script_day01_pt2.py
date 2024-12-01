import os
import pandas as pd

input = pd.read_csv(
    os.path.join("2024", "day_01", "input_day01.txt"), sep="   ", header=None
)
input.columns = ["l1", "l2"]


def part2(input):
    l1 = list(input["l1"])
    l2 = list(input["l2"])

    count_array = []
    for value in l1:
        count_array.append(value * l2.count(value))

    return sum(count_array)


print(part2(input))
