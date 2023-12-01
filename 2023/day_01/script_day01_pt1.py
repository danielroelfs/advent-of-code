import pandas as pd
import re

input = pd.read_table("2023/day_01/input_day01.txt", names=["string"])

def day1(input, pt2=False):
    if pt2:
        input["string"] = input["string"].apply(lambda k: _translate(k))

    input["first_num"] = input["string"].apply(lambda k: re.search(r"\d+", k).group())
    input["first_num"] = input["first_num"].str[0]
    input["last_num"] = input["string"].apply(
        lambda k: re.search(r"\d+", k[::-1]).group()
    )
    input["last_num"] = input["last_num"].str[0]
    input["value"] = input["first_num"] + input["last_num"]

    return input["value"].astype(int).sum()


print(day1(input, pt2=False))
