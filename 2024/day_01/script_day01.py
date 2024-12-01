### ADVENT OF CODE - DAY 1 ########################

# -- Libraries -------------------------

import os
import pandas as pd

# -- Load data ------------------------

input = pd.read_csv(
    os.path.join("2024", "day_01", "input_day01.txt"), sep="   ", header=None
)
input.columns = ["l1", "l2"]

# -- Part 1 ------------------------

# Your actual left and right lists contain many location IDs. What is the total distance between your lists?


def part1(input):
    l1 = list(input["l1"])
    l1.sort()
    l2 = list(input["l2"])
    l2.sort()

    df_lists = pd.DataFrame({"l1": l1, "l2": l2})
    df_lists["diff"] = abs(df_lists["l2"] - df_lists["l1"])

    return df_lists["diff"].sum()


print(part1(input))

# -- Part 2 ------------------------

# Once again consider your left and right lists. What is their similarity score?


def part2(input):
    l1 = list(input["l1"])
    l2 = list(input["l2"])

    count_array = []
    for value in l1:
        count_array.append(value * l2.count(value))

    return sum(count_array)


print(part2(input))
