#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo -e "\nYou forgot to provide the day number!\n"
    exit
fi

if [ "$#" -lt 2 ]; then
    echo -e "\nI'm assuming you're planning to do this in Python\n"
    suffix=`echo py`
else
    suffix=${2}
fi

day=`printf %02d $1`
year=`date +"%Y"`

mkdir -p ./${year}/day_${day}
touch ./${year}/day_${day}/input_day${day}.txt
touch ./${year}/day_${day}/test_input_day${day}.txt

echo """### ADVENT OF CODE - DAY ${1} ########################

# -- Libraries -------------------------

import os

# -- Load data ------------------------

input = open(os.path.join(\"${year}\", \"day_${day}\", \"input_day${day}.txt\")).read()

# -- Part 1 ------------------------

# 


# -- Part 2 ------------------------

# 

""" > ./${year}/day_${day}/script_day${day}.${suffix}

echo """# Advent of Code - Day ${1}

[link to the challenge](https://adventofcode.com/${year}/day/${1})""" > ./${year}/day_${day}/README.md

