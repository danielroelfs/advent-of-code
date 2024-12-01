import os
import pandas as pd

input = pd.read_csv(
    os.path.join("2024", "day_01", "input_day01.txt"), sep="   ", header=None
)
input.columns = ["l1", "l2"]


def part1(input):
    l1 = list(input["l1"])
    l1.sort()
    l2 = list(input["l2"])
    l2.sort()

    df_lists = pd.DataFrame({"l1": l1, "l2": l2})
    df_lists["diff"] = abs(df_lists["l2"] - df_lists["l1"])

    return df_lists["diff"].sum()


print(part1(input))
