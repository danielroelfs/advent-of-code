### ADVENT OF CODE - DAY 1 ########################

# -- Libraries -------------------------

import pandas as pd
import re

# -- Load data ------------------------

# input = pd.read_table("2023/day_01/test_input_day01.txt", names=["string"])
input = pd.read_table("2023/day_01/input_day01.txt", names=["string"])

# -- Part 1 ------------------------

# Consider your entire calibration document. What is the sum of all of the calibration values?


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

# -- Part 2 ------------------------

# What is the sum of all of the calibration values?

mapping = {
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
}


def _translate(s):
    for word in mapping:
        s = s.replace(word, word[0] + mapping[word] + word[~0])
    return s


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


print(day1(input, pt2=True))
